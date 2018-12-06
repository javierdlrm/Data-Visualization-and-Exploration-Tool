###################################################
##########        Europe stat Module       ########
###################################################

gdp_path <- "GDP/"

# Data preprocessing

source(str_c(gdp_path, "data-preprocessing.R"), local = TRUE)

# UI

gdp_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "GDP",
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
        column(width = 10, class = "content",
            box(width = 12,
                h4("GDP per capita, per country and year"),
                box(width = 7, class = "well box-note", span(HTML("NOTE:&emsp;&emsp;"), class = "accent-color"), span(HTML("<b>X-axis:</b> &emsp; Year &emsp;&emsp;&emsp; <b>Y-axis:</b> &emsp; GDP (per capita) &emsp;&emsp;&emsp; <b>Color:</b> &emsp; Country"))),
                streamgraphOutput(ns("plot_stream_gdp")),
                h4("GDP % for Healthcare, per country and year"),
                plotOutput(ns("plot.dot.gdp_healthcare")))))
}

# Server

gdp_server <- function(input, output, session) {

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

    # streamgraph

    output$plot_stream_gdp <- renderStreamgraph({
        req(values$europe_stats)
        req(values$years_selected)

        data <- values$europe_stats()[values$europe_stats()$year %in% values$years_selected,]
      
        streamgraph(data, key = "country.name", value = "gdp.pc", date = "year", interpolate = "cardinal") %>%
            sg_axis_x(tick_units = values$years_selected, tick_format = "%Y") %>%
            sg_fill_brewer("Spectral") %>%
            sg_legend(show = TRUE, label = "Country: ")
    })

    # dot chart

    output$plot.dot.gdp_healthcare <- renderPlot({
        req(values$europe_stats)
        req(values$years_selected)

        data <- values$europe_stats()[values$europe_stats()$year %in% values$years_selected,]

        ggplot(data = data, aes(x = country.name, y = year)) + geom_point(aes(size = health.gdp))
    })
}
