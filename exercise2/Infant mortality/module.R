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
            h5("General"),
            HTML("<label>Countries: </label>"),
            actionButton(ns("countries_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("countries_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('countries'), NULL, choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)),
            selectizeInput(ns('infant_variable_type'), "Infant mortality variable:", choices = c("Infant mortality rate" = "infant.mort", "Infant deaths" = "infant.deaths")),
            h5("Stack bar"),
            HTML("<label>Years: </label>"),
            actionButton(ns("years_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("years_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('years'), NULL, choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)),
            h5("Treemap and parallel coords"),
            sliderInput(ns("year"), "Year:", min = min(years), max = max(years), value = year, step = 1))),
        column(width = 10, class = "content",
            fluidRow(
                h4("Infant mortality per country and year"),
                box(width = 4, class = "well box-note", span(HTML("NOTE:&emsp;&emsp;"), class = "accent-color"), span(HTML("<b>X-axis:</b> &emsp; Year &emsp;&emsp;&emsp; <b>Y-axis:</b> &emsp; Infant mortality"))),
                streamgraphOutput(ns("plot_stream_infant_mort"))),
            fluidRow(
                h4("Infant mortality per CO2 emission level and country"),
                box(width = 7, class = "well box-note", span(HTML("NOTE:&emsp;&emsp;"), class = "accent-color"), span(HTML("<b>Groups:</b> &emsp; CO2 emission level &emsp;&emsp;&emsp; <b>Subgroups:</b> &emsp; Countries &emsp;&emsp;&emsp; <b>Square-size:</b> &emsp; Population"))),
                plotOutput(ns("plot_treemap_infant_mort"))),
            fluidRow(
                h4("Relation between GDP, infant mortality and life expectancy"),
                box(width = 4, class = "well box-note", span(HTML("NOTE:&emsp;&emsp;"), class = "accent-color"), span(HTML("<b>Color scale:</b> &emsp; Population"))),
                plotlyOutput(ns("plot_parcoords_infant_mort")))))
}

# Server

infant_mortality_server <- function(input, output, session) {

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
    observe({
        req(input$year)
        values$year <<- input$year
    })

    # plots

    # streamgraph

    output$plot_stream_infant_mort <- renderStreamgraph({
        req(values$europe_stats)
        req(values$years_selected)
        req(input$infant_variable_type)

        n_countries <- length(isolate(values$countries_selected))
        if (n_countries > 9) {
            my_colors <- colorRampPalette(brewer.pal(9, "Set1"))(n_countries)
        } else {
            my_colors <- brewer.pal(9, "Set1")
        }

        data <- values$europe_stats()[values$europe_stats()$year %in% values$years_selected,]

        if (input$infant_variable_type == "infant.mort") {
            graph <- streamgraph(data, key = "country.name", value = "infant.mort", date = "year", interpolate = "step", offset = "zero")
        } else {
            graph <- streamgraph(data, key = "country.name", value = "infant.deaths", date = "year", interpolate = "step", offset = "zero")
        }

        return(graph %>%
               sg_axis_x(tick_units = values$years_selected, tick_format = "%Y") %>%
               sg_fill_manual(values = my_colors) %>%
               sg_legend(show = TRUE, label = "Country: "))
    })

    # treemap

    output$plot_treemap_infant_mort <- renderPlot({
        req(values$europe_stats)
        req(values$year)
        req(input$infant_variable_type)

        my_colors <- colorRampPalette(brewer.pal(5, "Spectral"))(length(isolate(values$countries_selected)))

        aux_europe_stats <- values$europe_stats()[values$europe_stats()$year == values$year,]
        aux_europe_stats$population_norm <- aux_europe_stats$population / 100

        treemap(aux_europe_stats,
                index = c("co2.emission.level", "country.name"),
                vSize = "population_norm",
                vColor = input$infant_variable_type,
                type = "value",
                title = " ",
                title.legend = "Infant mortality",
                palette = my_colors,
                position.legend = "right",
                fontsize.title = 14)
    })

    # parallel coordinates

    output$plot_parcoords_infant_mort <- renderPlotly({
        req(values$europe_stats)
        req(values$year)
        req(input$infant_variable_type)

        data <- values$europe_stats()[values$europe_stats()$year == values$year,]

        if (input$infant_variable_type == "infant.mort") {
            infant_mort_variables <- data$infant.mort
        } else {
            infant_mort_variables <- data$infant.deaths
        }

        my_colors <- colorRampPalette(brewer.pal(8, "Set3"))(length(isolate(values$countries_selected)))

        data %>%
            plot_ly(showlegend = TRUE) %>%
            add_trace(line = list(color = data$population, showscale = TRUE, reversescale = TRUE),
                    type = 'parcoords',
                    dimensions = list(
                        list(range = c(~min(gdp.pc), ~ max(gdp.pc)),
                            label = 'GDP', values = ~gdp.pc),
                        list(range = c(~min(life.exp), ~ max(life.exp)),
                            label = 'Life expectancy', values = ~life.exp),
                        list(range = c(min(infant_mort_variables), max(infant_mort_variables)),
                            label = 'Infant mortality', values = infant_mort_variables),
                        list(range = c(~min(health.gdp), ~ max(health.gdp)),
                            label = 'GDP % for Healthcare', values = ~health.gdp)))
    })
}
