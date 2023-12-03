#' @title plot study type histogram
#' @description create a histogram of the study types returned by a brief title keyword search.
#' @param x the database table.
#' @return a histogram of the study types of the trials
#' @export
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
