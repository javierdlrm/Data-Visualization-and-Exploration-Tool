###################################################
##########       Population Module         ########
###################################################

population_path <- "Population/"

# Data preprocessing

source(str_c(population_path, "data-preprocessing.R"), local = TRUE)

# UI

population_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Population",
        column(width = 2, class = "sidebar", box(width = 12, h4(class = "accent-color", "Options"),
            h5("General"),
            HTML("<label>Select country: </label>"),
            selectizeInput(ns('country'), NULL, choices = countries, selected = NULL, multiple = FALSE, options = list(placeholder = 'Type a country name, e.g. Spain')),
            HTML("<label>Years: </label>"),
            actionButton(ns("years_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("years_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('years'), NULL, choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)))),
        column(width = 10, class = "content", box(width = 12,
            h4("Population per country and year"),
            plotOutput(ns("plot.histogram.population")))))
}

# Server

population_server <- function(input, output, session) {

    # years

    observe({
        req(input$years_reset)
        values$years_selected <<- isolate(values$years[1])
    })
    observe({
        req(input$years_select_all)
        values$years_selected <<- isolate(values$years)
    })
    observe({
        req(values$years_selected)
        if (length(isolate(input$years)) != length(values$years_selected)) {
            updateSelectizeInput(session, 'years', choices = isolate(values$years), selected = values$years_selected, server = TRUE)
        }
    })
    observe({
        req(input$years)
        if (length(input$years) != length(isolate(values$years_selected))) {
            values$years_selected <<- input$years
        }
    })

    # plots

    # histogram

    output$plot.histogram.population <- renderPlot({
        req(values$europe_stats)
        req(values$years_selected)
        req(input$country)

        data <- values$europe_stats()[values$europe_stats()$year %in% values$years_selected,]
        data <- data[data$country.name == input$country,]
        data$year <- as.factor(data$year)

        ggplot(data = data, aes(x = year, y = population)) +
            geom_histogram(stat = "identity", fill = "blue", alpha = .8)
    })
}
