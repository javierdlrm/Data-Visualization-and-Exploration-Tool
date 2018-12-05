
server <- function(input, output) {
    output$plot1 <- renderPlot({
        return(ggplot(europe_stats, aes(x = country.name, y = gdp.pc, label = country.name, mode = 'markers')) +
             geom_point(aes(size = infant.mort, colour = co2.emission.level)) +
             geom_text(hjust = 1, size = 2)
    )
    })
    #output$info <- renderText({
    # paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    #})
    output$plot2 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        #updateSelectizeInput(session, 'Country', choices = EuropeStat$Country, server = TRUE)
        cat(file = stderr(), "Country Graph", input$Country, "", "\n")
        filtered <- europe_stats[europe_stats$country.name == input$Country,]
        cat(file = stderr(), "filtered ", nrow(filtered), "", "\n")
        return(ggplot(filtered, aes(x = year, y = gdp.pc, color = life.exp)) + geom_bar(stat = "identity"))
    })
    output$plot3 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        return(ggplot(europe_stats, aes(x = europe_stats$year, y = europe_stats$infant.mort, color = europe_stats$country.name)) + geom_point(aes(size = europe_stats$co2.emission.pc)))
    })
    output$plot4 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        cat(file = stderr(), "Country Graph", input$Country, "", "\n")
        filtered <- europe_stats[europe_stats$country.name == input$Country,]
        cat(file = stderr(), "filtered ", nrow(filtered), "", "\n")
        ggplot(data = filtered, aes(x = year, y = population)) + geom_histogram(stat = "identity")
    })
    output$plot5 <- renderPlot({
        return(ggplot(data = europe_stats, aes(europe_stats$country.name, europe_stats$infant.mort, fill = europe_stats$year)) + geom_bar(stat = "identity"))
    })
    output$plot6 <- renderPlot({
        return(ggplot(data = europe_stats, aes(x = europe_stats$country.name, y = europe_stats$year)) + geom_tile(aes(fill = europe_stats$co2.emission.pc)))
    }
  )
    output$plot7 <- renderPlot({
        return(ggplot(data = europe_stats, aes(x = europe_stats$country.name, y = europe_stats$year)) + geom_tile(aes(fill = europe_stats$population), color = "white") + scale_fill_gradient(low = "white", high = "steelblue") + ylab("Years") + xlab("Countries") + theme(legend.title = element_text(size = 10), legend.text = element_text(size = 12), plot.title = element_text(size = 16), axis.title = element_text(size = 14, face = "bold"), axis.text.x = element_text(angle = 90, hjust = 1)))
    }
  )
    output$plot8 <- renderPlot({
        return(ggplot(data = europe_stats, aes(x = europe_stats$country.name, y = europe_stats$year, color = europe_stats$size)) + geom_point(aes(size = europe_stats$co2.emission))
      )
    }
  )
    #output$info <- renderText({
    # paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    #})

    ##output$info <- renderText({
    ##paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    ##})
}


ui <- fluidPage(
  selectizeInput('Country', "Countries: Filteration for GDP and Population", choices = europe_stats$country.name, options = list(
    placeholder = 'Type a Country name, e.g. Spain', maxOptions = 10)
  ),
  titlePanel("Countries in Europe"),
  tabsetPanel(
    tabPanel('Panel1', plotOutput('plot1')),
    tabPanel('Panel2', plotOutput('plot2')),
    tabPanel('Panel3', plotOutput('plot3')),
    tabPanel('Panel4', plotOutput('plot4')),
    tabPanel('Panel5', plotOutput('plot5')), #verbatimTextOutput("info"), click = "plot_click")
    tabPanel('Panel6', plotOutput('plot6')),
    tabPanel('Panel7', plotOutput('plot7')),
    tabPanel('Panel8', plotOutput('plot8'))
  )
)
shinyApp(ui, server)
