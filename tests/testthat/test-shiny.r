library(testthat)
library(bis620.2022)

test_that("startShinyApp launches Shiny app", {
  suppressMessages({
    startShinyApp()
  })
})
