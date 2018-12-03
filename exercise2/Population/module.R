###################################################
##########         Population Module       ########
###################################################

population_path <- "Population/"

# Data preprocessing

source(str_c(population_path, "data-preprocessing.R"), local = TRUE)

# UI

population_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Population",
        h5("Summary and plots"),
        plotOutput(ns("plot"), click = "plot_click"),
        plotOutput(ns("plot2")),
        verbatimTextOutput(ns("info")))
}

# Server

population_server <- function(input, output, session) {

    observe({
        req(values$population)
        
        # Enable run model
        #shinyjs::enable("button_run_model")
    })

    output$population.summary <- renderPrint({
        req(values$population)
        return(summary(values$population))
    })

    output$population.head <- renderTable({
        req(values$population)
        return(head(values$population))
    })

    output$population.tail <- renderTable({
        req(values$population)
        return(tail(values$population))
    })

    output$plot <- renderPlot({
        ##plot( HumanResourceTech$`Human resources in science and technology (HRST)`, Population$X__1)
        ggplot(NewPopulation, aes(NewPopulation$`Population without the citizenship of the reporting country`, y = NewPopulation$X__1)) + geom_bar(fill = "#0073C2FF", stat = "identity")
    })

    output$plot2 <- renderPlot({
        ggplot(Population, aes(x = Population$`Population without the citizenship of the reporting country`, y = Population$X__3)) +
            geom_bar(fill = "#0073C2FF", stat = "identity")
    })

    output$info <- renderPrint({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
}
