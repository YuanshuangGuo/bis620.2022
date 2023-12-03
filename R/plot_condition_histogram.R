#' @title plot condition histogram
#' @description create a histogram of the conditions that trials are examining
#' returned by a brief title keyword search
#' @param x the database table.
#' @param condition the condition table. (default: condi; the tibble of the
#' condition table)
#' @return a histogram of the conditions of the  trials
#' @export
plot_condition_histogram = function(x, condition = condi){
  condi_plot = condition |>
    select(nct_id, name) |>
    filter(nct_id %in% x$nct_id) |>
    group_by(name) |>
    summarize(n = n())

  ggplot(condi_plot, aes(x = name, y = n)) +
    geom_bar(stat = "identity")
}
