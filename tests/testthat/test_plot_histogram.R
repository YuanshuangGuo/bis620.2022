library(tidyr)
library(dplyr)
library(ggplot2)

test_that("plot_condition_histogram() works", {
  data(condi)
  data(studies)
  vdiffr::expect_doppelganger(
    "plot-condition-hist",
    studies |> head(100) |> plot_condition_histogram()
  )
})
