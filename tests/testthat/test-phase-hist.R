library(tidyr)
library(dplyr)
library(ggplot2)

test_that("plot_phase_histogram() works", {
  data(studies)
  vdiffr::expect_doppelganger(
    "plot-phase-hist",
    studies |> head(100) |> plot_phase_histogram()
  )
})
