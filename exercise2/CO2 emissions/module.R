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
        h5("Summary and plots"),
        plotOutput(ns("plot"), click = "plot_click"),
        verbatimTextOutput(ns("info")))
}

# Server

co2_emissions_server <- function(input, output, session) {

    observe({
        req(values$co2_emissions)

        # Enable run model
        #shinyjs::enable("button_run_model")
    })

    output$co2_emissions.summary <- renderPrint({
        req(values$co2_emissions)
        return(summary(values$co2_emissions))
    })

    output$co2_emissions.head <- renderTable({
        req(values$co2_emissions)
        return(head(values$co2_emissions))
    })

    output$co2_emissions.tail <- renderTable({
        req(values$co2_emissions)
        return(tail(values$co2_emissions))
    })

    output$plot <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(data = Newco2_emissions, aes(Newco2_emissions$`Pollutant emissions from transport`, y = Newco2_emissions$X__1)) + geom_histogram(stat = "identity")
    })

    output$plot2 <- renderPlot({
        ggplot(co2_emissions, aes(x = Pollution$`Pollutant emissions from transport`, y = Pollution$X__9)) +
            geom_bar(fill = "#0073C2FF", stat = "identity")
    })

    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
}
