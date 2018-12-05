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
            selectizeInput(ns('countries'), "Countries:", choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)))),
        column(width = 10, class = "content",
            box(width = 12,
                h4("GDP per capita, per country and year"),
                streamgraphOutput(ns("plot_stream_gdp")),
                h4("GDP % for Healthcare, per country and year"),
                plotOutput(ns("plot.dot.gdp_healthcare")))))
        #selectizeInput(ns('country.name'), "Countries: Filteration for UnEmployment, GDP and Population growth", choices = countries,
            #options = list(placeholder = 'Type a Country name, e.g. Spain', maxOptions = 10)),
        #plotOutput(ns("summary.gdp")),
        #plotOutput(ns("plot.box.gdp"))
        #verbatimTextOutput("info"),
        #plotOutput(ns("plot2")),
        #plotOutput(ns("plot3")),
        #plotOutput(ns("plot4")),
        #plotOutput(ns("plot")),
        #leafletOutput("mymap"),
        #actionButton("recalc", "New points")
}

# Server

gdp_server <- function(input, output, session) {

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

    output$plot_stream_gdp <- renderStreamgraph({
        req(values$europe_stats)
        streamgraph(values$europe_stats(), key = "country.name", value = "gdp.pc", date = "year", interpolate = "cardinal") %>%
            sg_axis_x(1, "year", "%Y") %>%
            sg_fill_brewer("Spectral") %>%
            sg_legend(show = TRUE, label = "Country names: ")
    })

    output$plot.dot.gdp_healthcare <- renderPlot({
        req(values$europe_stats)
        ggplot(data = values$europe_stats(), aes(x = country.name, y = year)) + geom_point(aes(size = health.gdp))
    })
}
