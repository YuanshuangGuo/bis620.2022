library(dplyr)
library(duckdb)
library(dplyr)
library(DBI)
library(DT)
library(ggplot2)
library(purrr)

# Create the connection to a database and "studies" and "sponsors" tables.

con = dbConnect(
  duckdb(
    file.path("..", "ctrialsgovdb", "ctrialsgov.duckdb"),
    read_only = TRUE
  )
)

if (length(dbListTables(con)) == 0) {
  stop("Problem reading from connection.")
}
studies = tbl(con, "studies")
sponsors = tbl(con, "sponsors")
conditions = tbl(con,"conditions")
condi = collect(conditions)
studies_tbl = collect(studies)

#' @title Query keywords from a database table.
#' @description Description goes here.
#' @param d the database table.
#' @param kwds the keywords to look for.
#' @param column the column to look for the keywords in.
#' @param ignore_case should the case be ignored when searching for a keyword?
#' (default TRUE)
#' @param match_all should we look for values that match all of the keywords
#' (intersection) or any of the keywords (union)? (default FALSE; union).
query_kwds <- function(d, kwds, column, ignore_case = TRUE, match_all = FALSE) {
  kwds = kwds[kwds != ""]
  kwds = paste0("%", kwds, "%") |>
    gsub("'", "''", x = _)
  if (ignore_case) {
    like <- " ilike "
  } else{
    like <- " like "
  }
  query = paste(
    paste0(column, like, "'", kwds, "'"),
    collapse = ifelse(match_all, " AND ", " OR ")
  )
  filter(d, sql(query))
}

# Create a histogram of the phases returned by a brief title keyword search
# @param d the database table.
# @param brief_title_kw the brief title keywords to look for. This is optional.
plot_phase_histogram = function(x) {
  phaseList <- c("Phase 1" , "Phase 2" , "Not Applicable",
                 "Phase 1/Phase 2" , "Phase 4" , "Phase 3" ,
                 "Phase 2/Phase 3" , "Early Phase 1")

  countn <- numeric(length(phaseList))
  for (i in 1: length(countn)){
    countn[i] <- sum(x$phase == phaseList[i], na.rm = TRUE)
  }

  countn <- c(sum(is.na(x$phase)), countn)
  phaseList <- c("NA", phaseList)

  plot_df <- data.frame(phaseList = phaseList, countn = countn)
  ggplot(plot_df, aes(x = phaseList, y = countn)) +
    geom_col() +
    theme_bw() +
    xlab("Phase") +
    ylab("Count")
}

#' Create a histogram of the conditions that trials are examining
#' returned by a brief title keyword search
#' @param x the database table.
#' @param condition the condition table. (default: condi; the tibble of the
#' condition table)
plot_condition_histogram = function(x, condition = condi){
  condi_plot = condition |>
    select(nct_id, name) |>
    filter(nct_id %in% x$nct_id) |>
    group_by(name) |>
    summarize(n = n())

  ggplot(condi_plot, aes(x = name, y = n)) +
    geom_bar(stat = "identity")
}

#' Get the number of concurrent trials for each date in a set of studies
#' @param d the studies to get the number of concurrent trials for.
#' @return A tibble with a `date` column and a `count` of the number of
#' concurrent trials at that date.
get_concurrent_trials = function(d) {
  # Get all of the unique dates.
  all_dates = d |>
    pivot_longer(cols = everything()) |>
    select(-name) |>
    distinct() |>
    arrange(value) |>
    na.omit() |>
    rename(date = value)

  within_date = function(date, starts, ends) {
    date >= starts & date <= ends
  }

  # Get the number of concurrent trials at each of the unique dates.
  all_dates$count =
    map_dbl(
      all_dates$date,
      ~ .x |>
        within_date(d$start_date, d$completion_date) |>
        sum(na.rm = TRUE)
    )
  return(all_dates)
}

#' Create a line plot of the number of concurrent studies versus time.
#' returned by a brief title keyword search
#' @param x the database table.
plot_concurrent_studies = function(x) {
  x |>
    select(start_date, completion_date) |>
    get_concurrent_trials() |>
    ggplot(aes(x = date, y = count)) +
    geom_line() +
    xlab("Date") +
    ylab("Count") +
    theme_bw()
}

#' Create a histogram of the study types returned by a brief title keyword search.
#' @param x the database table.
plot_study_type_histogram = function(x) {
  x$study_type[is.na(x$study_type)] = "NA"
  x = x |>
    select(study_type) |>
    group_by(study_type) |>
    summarize(n = n())

  ggplot(x, aes(x = study_type, y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Study type") +
    ylab("Count")
}

#' Create a piechart plot of the number of arms returned by a
#' brief title keyword search.
#' @param x the database table.
plot_num_arms = function(x){
  x$number_of_arms[is.na(x$number_of_arms)] = "NA"
  x_plot = x |>
    select(number_of_arms) |>
    group_by(number_of_arms) |>
    summarize(n = n())

  ggplot(x_plot, aes(x = number_of_arms, y=n, fill = n)) +
    geom_bar(stat="identity", width=1) +
    coord_polar("y", start=0)
}
