###################################################
##########        Europe stat Module       ########
###################################################

europe_stats_path <- "Europe stats/"

# Data preprocessing

source(str_c(europe_stats_path, "data-preprocessing.R"), local = TRUE)

# UI

europe_stats_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Europe Stat",
        h5("Summary and plots"),
        plotOutput(ns("plot1")),
        verbatimTextOutput("info"),
        plotOutput(ns("plot2")),
        plotOutput(ns("plot3")),
        plotOutput(ns("plot4")),
        plotOutput(ns("plot")),
        leafletOutput("mymap"),
        actionButton("recalc", "New points")
        )
}

# Server

europe_stats_server <- function(input, output, session) {

    observe({
        req(values$europe_stats)

        # Enable run model
        #shinyjs::enable("button_run_model")
    })

    output$europe_stats.summary <- renderPrint({
        req(values$europe_stats)
        return(summary(values$europe_stats))
    })

    output$europe_stats.head <- renderTable({
        req(values$europe_stats)
        return(head(values$europe_stats))
    })

    output$europe_stats.tail <- renderTable({
        req(values$europe_stats)
        return(tail(values$europe_stats))
    })

    output$plot1 <- renderPlot({
        return(ggplot(EuropeStat, aes(x = EuropeStat$Country, y = EuropeStat$GDP)) + geom_boxplot())
    })
    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
    output$plot2 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        return(ggplot(EuropeStat, aes(x = EuropeStat$Country, y = EuropeStat$Unemployment)) + geom_point() + geom_smooth(method = "lm"))
    })
    output$plot3 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(NewInfantMortality, aes(NewInfantMortality$`Infant mortality rate`, y = NewInfantMortality$X__1)) + geom_point() + geom_smooth(method = "lm")
    })
    output$plot4 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(data = NewPollution, aes(NewPollution$`Pollutant emissions from transport`, y = NewPollution$X__1)) + geom_histogram(stat = "identity")
    })

    ##output$info <- renderText({
        ##paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    ##})

    points <- eventReactive(input$recalc, {
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)

    output$mymap <- renderLeaflet({
            selectizeInput()

            leaflet(data = EuropeStat$Pop.growth) %>%
          addProviderTiles(providers$Stamen.TonerLite,
                           options = providerTileOptions(noWrap = TRUE)
          ) %>%
          addMarkers(data = points())
    })
}
