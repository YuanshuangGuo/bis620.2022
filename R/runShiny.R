#' Start the Shiny App
#' @export

startShinyApp <- function() {
  appDir <- system.file("shinyApp", package = "bis620.2022")
  if (appDir != "") {
    shiny::runApp(appDir)
  } else {
    stop("directory not found")
  }
}

