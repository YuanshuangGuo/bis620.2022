library(tidyr)
library(dplyr)
library(ggplot2)

test_that("plot_study_type_histogram() works", {
  data(studies)
  vdiffr::expect_doppelganger(
    "plot-study-type-hist",
    studies |> head(100) |> plot_study_type_histogram()
  )
})
