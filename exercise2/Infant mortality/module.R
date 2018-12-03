###################################################
#######      Infant mortality Module       ########
###################################################

infant_mortality_path <- "InfantMortality/"

# Data preprocessing

source(str_c(infant_mortality_path, "data-preprocessing.R"), local = TRUE)

# UI

infant_mortality_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Infant mortality",
        h5("Summary and plots"),
        plotOutput(ns("plot"=, click = "plot_click"),
        verbatimTextOutput(ns("info")),
        plotOutput(ns("plot2"), brush = "plot_brush"),
        verbatimTextOutput(ns("info2")),
        selectInput("Countries", "Countries:", c("Spain",))))
}

# Server

infant_mortality_server <- function(input, output, session) {

    observe({
        req(values$infant_mortality)

        # Enable run model
        #shinyjs::enable("button_run_model")
    })

    output$infant_mortality.summary <- renderPrint({
        req(values$infant_mortality)
        return(summary(values$infant_mortality))
    })

    output$infant_mortality.head <- renderTable({
        req(values$infant_mortality)
        return(head(values$infant_mortality))
    })

    output$infant_mortality.tail <- renderTable({
        req(values$infant_mortality)
        return(tail(values$infant_mortality))
    })

    output$plot <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(NewInfantMortality, aes(NewInfantMortality$`Infant mortality rate`, y = NewInfantMortality$X__1)) + geom_point() + geom_smooth(method = "lm")
    })

    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })

    output$plot2 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(NewInfantMortality, aes(NewInfantMortality$`Infant mortality rate`, y = NewInfantMortality$X__1)) + geom_point() + geom_smooth(method = "lm")
    })

    output$info2 <- renderPrint({
        brushedPoints(InfantMortality, input$plot_brush, allRows = TRUE)
    })
}
