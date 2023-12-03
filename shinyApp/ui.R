#
# This is a Shiny web application.
#


library(shiny)
library(shinyWidgets)


source("util.R")
max_num_studies = 1000

# Define UI for application that draws the plots of interest
ui <- fluidPage(

  # Application title
  titlePanel("Clinical Trials Query"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("brief_title_kw", "Brief title keywords"),

      #Add the drop-down menu of Sponsor Type
      pickerInput(inputId = 'sponsor_type',
                  label = 'Sponsor Type',
                  choices = c("ALL",unique(studies_tbl$source_class)),
                  options = list(`style` = "btn-info")),

      #Add check box of study overall status (Feature 1)
      checkboxGroupInput("overall_status",label = h3("Overall Status"),
                         choices = list("Completed" = "Completed" ,
                                        "Unknown status" = "Unknown status" ,
                                        "Terminated" = "Terminated" ,
                                        "Recruiting" = "Recruiting" ,
                                        "Withdrawn" = "Withdrawn" ,
                                        "Not yet recruiting" = "Not yet recruiting",
                                        "Active, not recruiting" = "Active, not recruiting",
                                        "Enrolling by invitation" = "Enrolling by invitation",
                                        "Withheld" = "Withheld",
                                        "Approved for marketing" = "Approved for marketing",
                                        "Suspended" = "Suspended",
                                        "No longer available" = "No longer available",
                                        "Available"= "Available",
                                        "Temporarily not available" = "Temporarily not available"
                         )),

      # Add date range input (Feature 2)
      dateRangeInput("date_range", "Date Range", start = "1900-01-01", end = "2100-12-31")
    ),

    # Show a plot of the generated distributions
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Phase", plotOutput("phase_plot")),
        tabPanel("Condition", plotOutput("condition_plot")),
        tabPanel("Concurrent", plotOutput("concurrent_plot")),

        # Add a new tab of the histogram of study type (Feature 3)
        tabPanel("Study Type", plotOutput("study_type")),

        # Add a new tab of piechart plot of number of arms (Feature 4)
        tabPanel("Number of Arms", plotOutput("arms_plot"))

      ),
      dataTableOutput("trial_table")
    )
  )
)
