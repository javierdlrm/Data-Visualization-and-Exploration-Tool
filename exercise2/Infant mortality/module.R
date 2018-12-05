###################################################
#######      Infant mortality Module       ########
###################################################

infant_mortality_path <- "Infant mortality/"

# Data preprocessing

source(str_c(infant_mortality_path, "data-preprocessing.R"), local = TRUE)

# UI

infant_mortality_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Infant mortality",
        column(width = 2, class = "sidebar", box(width = 12, h4(class = "accent-color", "Options"),
            selectizeInput(ns('countries'), "Countries:", choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)),
            selectizeInput(ns('years'), "Years:", choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)),
            selectizeInput(ns('infant_variable_type'), "Infant mortality variable:", choices = c("Infant mortality rate" = "infant.mort", "Infant deaths" = "infant.deaths")))),
        column(width = 10, class = "content", box(width = 12,
            h4("Infant mortality per country and year"),
            streamgraphOutput(ns("plot_stream_infant_mort")),
            h4("Infant mortality per CO2 emission level and country"),
            plotOutput(ns("plot.treemap.infant_mort")),
            h4("Relation between GDP and infant mortality"),
            h5(class = "accent-color", "NOTE: Color scale = population of the country"),
            plotlyOutput(ns("plot.parcoords.infant_mort")))))
}

# Server

infant_mortality_server <- function(input, output, session) {

    # countries

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
    output$plot_stream_infant_mort <- renderStreamgraph({
        req(values$europe_stats)
        req(input$infant_variable_type)
        
        if (input$infant_variable_type == "infant.mort") {
            return(streamgraph(values$europe_stats(), key = "country.name", value = "infant.mort", date = "year", interpolate = "step", offset = "zero") %>%
                sg_axis_x(tick_units = isolate(values$years_selected), tick_format = "%Y") %>%
                sg_fill_brewer("Spectral") %>%
                sg_legend(show = TRUE, label = "Country names: "))
        } else {
            return(streamgraph(values$europe_stats(), key = "country.name", value = "infant.deaths", date = "year", interpolate = "step", offset = "zero") %>%
                sg_axis_x(1, "year", "%Y") %>%
                sg_fill_brewer("Spectral") %>%
                sg_legend(show = TRUE, label = "Country names: "))
        }
    })

    # treemap
    output$plot.treemap.infant_mort <- renderPlot({
        req(values$europe_stats)
        req(input$infant_variable_type)

        my_colors <- brewer.pal(5, "Spectral")
        my_colors = colorRampPalette(my_colors)(100)

        treemap(values$europe_stats(),
                index = c("co2.emission.level", "country.name"),
                vSize = "area",
                vColor = input$infant_variable_type,
                type = "value",
                title = "Infant mortality",
                palette = my_colors,
                position.legend = "right",
                fontsize.title = 14)
    })

    # parallel coordinates
    output$plot.parcoords.infant_mort <- renderPlotly({
        req(values$europe_stats)
        req(input$infant_variable_type)

        if (input$infant_variable_type == "infant.mort") {
            infant_mort_variables <- values$europe_stats()$infant.mort
        } else {
            infant_mort_variables <- values$europe_stats()$infant.deaths
        }

        my_colors <- brewer.pal(5, "Set3")
        my_colors = colorRampPalette(my_colors)(420)
        
        values$europe_stats() %>%
            plot_ly(showlegend = TRUE) %>%
            add_trace(line = list(color = values$europe_stats()$population, showscale = TRUE, reversescale = TRUE),
                    type = 'parcoords',
                    dimensions = list(
                        list(range = c(~min(gdp.pc), ~max(gdp.pc)),
                            label = 'GDP', values = ~gdp.pc),
                        list(range = c(~min(life.exp), ~max(life.exp)),
                            label = 'Life expectancy', values = ~life.exp),
                        list(range = c(min(infant_mort_variables), max(infant_mort_variables)),
                            label = 'Infant mortality', values = infant_mort_variables),
                        list(range = c(~min(health.gdp), ~ max(health.gdp)),
                            label = 'GDP % for Healthcare', values = ~health.gdp)))
    })
}
