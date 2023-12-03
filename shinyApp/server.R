# Define server logic required to draw the plots

server <- function(input, output) {

  get_studies = reactive({
    if (input$brief_title_kw != ""){
      si = input$brief_title_kw |>
        strsplit(",") |>
        unlist() |>
        trimws()
      ret = query_kwds(studies, si, "brief_title", match_all = TRUE)
    } else {
      ret = studies
    }

    # Filter on sponsor type
    if (input$sponsor_type != "ALL"){
      ret = ret |> filter(source_class %in% !!input$sponsor_type)
    }

    # Filter on overall status (Feature 1)
    if (!is.null(input$overall_status)){
      ret = ret |> filter(overall_status %in% !!input$overall_status)
    }

    # Filter on study completion date (Feature 2)
    ret |>
      head(max_num_studies) |>
      collect() |>
      filter(completion_date >= input$date_range[1] & completion_date <= input$date_range[2])
  })


  # Output histogram of phase
  output$phase_plot = renderPlot({
    get_studies() |>
      plot_phase_histogram()
  })

  # Output histogram of condition
  output$condition_plot = renderPlot({
    get_studies() |>
      plot_condition_histogram()
  })

  # Output concurrent plot
  output$concurrent_plot = renderPlot({
    get_studies() |>
      plot_concurrent_studies()
  })

  # Output summary table
  output$trial_table = renderDataTable({
    get_studies() |>
      select(nct_id, brief_title, start_date, completion_date) |>
      rename(`NCT ID` = nct_id, `Brief Title` = brief_title,
             `Start Date` = start_date, `Completion Date` = completion_date)
  })

  # Output histogram of study type (Feature 3)
  output$study_type = renderPlot({
    get_studies() |>
      plot_study_type_histogram()
  })

  # Output piechart plot of number of arms (Feature 4)
  output$arms_plot = renderPlot({
    get_studies() |>
      plot_num_arms()
  })
}
