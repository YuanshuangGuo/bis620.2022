#' @title plot phase histogram
#' @description create a histogram of the phases returned by a brief title keyword search
#' @param x the database table.
#' @return a histogram of the phase of the query
#' @export
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
