library(tidyr)
library(dplyr)
library(ggplot2)

test_that("plot_num_arms() works", {
  data(studies)
  vdiffr::expect_doppelganger(
    "plot-num-arm-piechart",
    studies |> head(100) |> plot_num_arms()
  )
})
