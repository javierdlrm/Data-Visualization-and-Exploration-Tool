###################################################
##########      CO2 emissions Module       ########
###################################################

co2_emissions_path <- "CO2 emissions/"

# Data preprocessing

source(str_c(co2_emissions_path, "data-preprocessing.R"), local = TRUE)

# UI

co2_emissions_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "CO2 emissions",
        column(width = 2, class = "sidebar", box(width = 12, h4(class = "accent-color", "Options"),
            h5("General"),
            HTML("<label>Countries: </label>"),
            actionButton(ns("countries_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("countries_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('countries'), NULL, choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)),
            HTML("<label>Years: </label>"),
            actionButton(ns("years_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("years_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('years'), NULL, choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)))),
        column(width = 10, class = "content", box(width = 12,
            h4("CO2 emissions per country and year"),
            plotOutput(ns("plot.tile.co2_emission")))))
}

# Server

co2_emissions_server <- function(input, output, session) {

    # countries

    observe({
        req(input$countries_reset)
        values$countries_selected <<- isolate(values$countries[1])
    })

    observe({
        req(input$countries_select_all)
        values$countries_selected <<- isolate(values$countries)
    })

    observe({
        req(values$countries_selected)
        if (length(isolate(input$countries)) != length(values$countries_selected)) {
            updateSelectizeInput(session, 'countries', choices = isolate(values$countries), selected = values$countries_selected, server = TRUE)
        }
    })
    observe({
        req(input$countries)
        if (length(input$countries) != length(isolate(values$countries_selected))) {
            values$countries_selected <<- input$countries
        }
    })

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

    # heatmap

    output$plot.tile.co2_emission <- renderPlot({
        req(values$europe_stats)
        req(values$years_selected)

        data <- values$europe_stats()[values$europe_stats()$year %in% values$years_selected,]
        data$sqrt.co2.emission.pc <- sqrt(data$co2.emission.pc)
        data$year <- as.factor(data$year)

        ggplot(data = data, aes(x = country.name, y = year, fill = sqrt.co2.emission.pc)) +
            geom_tile(show.legend = TRUE) +
            geom_text(aes(label = round(sqrt.co2.emission.pc, digits = 2)), colour = "lightgray") +
            labs(x = "Country", y = "Year") +
            scale_x_discrete(expand = c(0, 0)) +
            scale_y_discrete(expand = c(0, 0)) +
            scale_fill_continuous(name = "CO2 emission (per capita)")
    })
}
