#' @title plot number of arms pirchart
#' @description create a piechart plot of the number of arms returned by a
#' brief title keyword search.
#' @param x the database table.
#' @return a piechart plot of the number of arms of the trials
#' @export
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
