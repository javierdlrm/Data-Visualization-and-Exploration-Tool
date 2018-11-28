# Population
library(gdata)
library(readxl)
Population <- read_excel("Population.xls")
Population

# Cleaning of Population Dataset

# Trimming whitespaces and replacing missing values
install.packages("stringr")
library(stringr)
Population$X__1 <- str_replace(Population$X__1, ":", "Not Available")
Population
Population$X__2 <- str_replace(Population$X__2, ":", "Not Available")
Population$X__3 <- str_replace(Population$X__3, ":", "Not Available")
Population$X__4 <- str_replace(Population$X__4, ":", "Not Available")
Population$X__5 <- str_replace(Population$X__5, ":", "Not Available")
Population$X__6 <- str_replace(Population$X__6, ":", "Not Available")
Population$X__7 <- str_replace(Population$X__7, ":", "Not Available")
Population
Population$X__8 <- str_replace(Population$X__8, ":", "Not Available")
Population$X__9 <- str_replace(Population$X__9, ":", "Not Available")
Population$X__10 <- str_replace(Population$X__10, ":", "Not Available")
Population$X__11 <- str_replace(Population$X__11, ":", "Not Available")
Population$X__12 <- str_replace(Population$X__12, ":", "Not Available")
Population$X__13 <- str_replace(Population$X__13, ":", "Not Available")
Population$X__14 <- str_replace(Population$X__14, ":", "Not Available")
Population$X__15 <- str_replace(Population$X__15, ":", "Not Available")
Population$X__16 <- str_replace(Population$X__16, ":", "Not Available")
Population$X__17 <- str_replace(Population$X__17, ":", "Not Available")
Population$X__18 <- str_replace(Population$X__18, ":", "Not Available")
Population$X__19 <- str_replace(Population$X__19, ":", "Not Available")
Population$X__20 <- str_replace(Population$X__20, ":", "Not Available")
Population$X__21 <- str_replace(Population$X__21, ":", "Not Available")
Population$X__22 <- str_replace(Population$X__22, ":", "Not Available")
Population$X__23 <- str_replace(Population$X__23, ":", "Not Available")
Population$X__24 <- str_replace(Population$X__24, ":", "Not Available")
any(is.na(Population))
sum(is.na(Population))
na.omit(Population)
Population
na.omit(Population)
#Interpretation of columns and removing unnecessory values
install.packages("tidyr")
library(tidyr)
Population$X__2 = NULL
Population$X__2 = NULL
Population$X__4 = NULL
Population$X__6 = NULL
Population$X__8 = NULL
Population$X__10 = NULL
Population$X__12 = NULL
Population$X__14 = NULL
Population$X__16 = NULL
Population$X__18 = NULL
Population$X__20 = NULL
Population$X__22 = NULL
Population$X__24 = NULL
Population$X__26 = NULL
Population
#Interpreting rows
Population <- Population[2:nrow(Population),]
Population <- Population[2:nrow(Population),]
Population <- Population[2:nrow(Population),]
#VisualPlot after cleaning for Percentage popuation in 2010
library(ggplot2)
Population
ggplot(Population, aes(x = Population$`Population without the citizenship of the reporting country`, y = Population$X__3)) +
  geom_bar(fill = "#0073C2FF", stat = "identity")
library(dplyr)
install.packages("sqldf")
library(sqldf)
Population
Population <- Population[!grepl(":", Population$`Population without the citizenship of the reporting country`),]
Population[!grepl("<NA>", Population$X__1),]
Population[!grepl("Not Available", Population$X__1),]
Population
NewPopulation <- sqldf("SELECT * FROM Population
                     ORDER BY X__1 ASC 
                     LIMIT 10", row.names = TRUE)
NewPopulation
##NewPopulation<-Population[(4:5:6:7:8:9:10:11),(1:2)]
NewPopulation
# Load packages ----
Population
library(shiny)
library(maps)
library(mapproj)

#Pollution
#Cleaning of Pollution Dataset
Pollution <- read_excel("Pollution.xls")
Pollution
class(Pollution)
dim(Pollution)
#Summarizing the dataset
summary(Pollution)

Pollution$X__1 <- str_replace(Pollution$X__1, ":", "Not Available")
Pollution
Pollution$X__2 <- str_replace(Pollution$X__2, ":", "Not Available")
Pollution$X__3 <- str_replace(Pollution$X__3, ":", "Not Available")
Pollution$X__4 <- str_replace(Pollution$X__4, ":", "Not Available")
Pollution$X__5 <- str_replace(Pollution$X__5, ":", "Not Available")
Pollution$X__6 <- str_replace(Pollution$X__6, ":", "Not Available")
Pollution$X__7 <- str_replace(Pollution$X__7, ":", "Not Available")
Pollution
Pollution$X__8 <- str_replace(Pollution$X__8, ":", "Not Available")
Pollution$X__9 <- str_replace(Pollution$X__9, ":", "Not Available")
Pollution$X__10 <- str_replace(Pollution$X__10, ":", "Not Available")
Pollution$X__11 <- str_replace(Pollution$X__11, ":", "Not Available")
Pollution$X__12 <- str_replace(Pollution$X__12, ":", "Not Available")
Pollution$X__13 <- str_replace(Pollution$X__13, ":", "Not Available")
Pollution$X__14 <- str_replace(Pollution$X__14, ":", "Not Available")
Pollution$X__15 <- str_replace(Pollution$X__15, ":", "Not Available")
Pollution$X__16 <- str_replace(Pollution$X__16, ":", "Not Available")
Pollution$X__17 <- str_replace(Pollution$X__17, ":", "Not Available")
Pollution$X__18 <- str_replace(Pollution$X__18, ":", "Not Available")
Pollution$X__19 <- str_replace(Pollution$X__19, ":", "Not Available")
Pollution$X__20 <- str_replace(Pollution$X__20, ":", "Not Available")
Pollution$X__21 <- str_replace(Pollution$X__21, ":", "Not Available")
Pollution$X__22 <- str_replace(Pollution$X__22, ":", "Not Available")
Pollution$X__23 <- str_replace(Pollution$X__23, ":", "Not Available")
Pollution$X__24 <- str_replace(Pollution$X__24, ":", "Not Available")
Pollution$X__25 <- str_replace(Pollution$X__25, ":", "Not Available")
Pollution$X__27 <- str_replace(Pollution$X__27, ":", "Not Available")
Pollution$X__29 <- str_replace(Pollution$X__29, ":", "Not Available")
Pollution$X__31 <- str_replace(Pollution$X__31, ":", "Not Available")
Pollution$X__33 <- str_replace(Pollution$X__33, ":", "Not Available")
Pollution$X__35 <- str_replace(Pollution$X__35, ":", "Not Available")
Pollution$X__37 <- str_replace(Pollution$X__37, ":", "Not Available")
Pollution$X__39 <- str_replace(Pollution$X__39, ":", "Not Available")
Pollution$X__41 <- str_replace(Pollution$X__41, ":", "Not Available")
Pollution$X__43 <- str_replace(Pollution$X__43, ":", "Not Available")
Pollution$X__45 <- str_replace(Pollution$X__45, ":", "Not Available")
Pollution$X__47 <- str_replace(Pollution$X__47, ":", "Not Available")

#Removing unnecessory columns
Pollution$X__2 = NULL
Pollution$X__4 = NULL
Pollution$X__6 = NULL
Pollution$X__8 = NULL
Pollution$X__10 = NULL
Pollution$X__12 = NULL
Pollution$X__14 = NULL
Pollution$X__16 = NULL
Pollution$X__18 = NULL
Pollution$X__20 = NULL
Pollution$X__22 = NULL
Pollution$X__24 = NULL
Pollution$X__26 = NULL
Pollution$X__28 = NULL
Pollution$X__30 = NULL
Pollution$X__32 = NULL
Pollution$X__34 = NULL
Pollution$X__36 = NULL
Pollution$X__38 = NULL
Pollution$X__40 = NULL
Pollution$X__42 = NULL
Pollution$X__44 = NULL
Pollution$X__46 = NULL
Pollution$X__48 = NULL
Pollution$X__50 = NULL
Pollution$X__52 = NULL
Pollution$X__54 = NULL
Pollution
#Interpreting Rows
Pollution <- Pollution[2:nrow(Pollution),]
Pollution <- Pollution[2:nrow(Pollution),]
Pollution <- Pollution[2:nrow(Pollution),]
Pollution
#VisualPlot after cleaning for Percentage popuation in 2010
library(ggplot2)
ggplot(Pollution, aes(x = Pollution$`Pollutant emissions from transport`, y = Pollution$X__9)) +
  geom_bar(fill = "#0073C2FF", stat = "identity")
NewPollution <- Pollution[!grepl(":=not available", Pollution$`Pollutant emissions from transport`),]
NewPollution <- Pollution[!grepl(":", Pollution$`Pollutant emissions from transport`),]
NewPollution <- sqldf("SELECT * FROM NewPollution
                    ORDER BY X__1 ASC 
                    LIMIT 10", row.names = TRUE)


#Aggregation of two dataframes
#Checking Dimensions
dim(data2)

dim(Pollution)
#Binding two dataframes


#Employment


#InfantMortality and GDPPerCapita
library(readxl)
InfantMortality <- read_excel("InfantMortality.xls")
GDPPerCapita <- read_excel("GDPPerCapita.xls")
library(stringr)
library(tidyr)
InfantMortality$X__2 = NULL
InfantMortality$X__4 = NULL
InfantMortality$X__6 = NULL
InfantMortality$X__8 = NULL
InfantMortality$X__10 = NULL
InfantMortality$X__12 = NULL
InfantMortality$X__14 = NULL
InfantMortality$X__16 = NULL
InfantMortality$X__18 = NULL
InfantMortality$X__20 = NULL
InfantMortality$X__22 = NULL
InfantMortality$X__24 = NULL

InfantMortality

InfantMortality$X__1 <- str_replace(InfantMortality$X__1, ":", "Not Available")
InfantMortality$X__3 <- str_replace(InfantMortality$X__3, ":", "Not Available")
InfantMortality$X__5 <- str_replace(InfantMortality$X__5, ":", "Not Available")
InfantMortality$X__7 <- str_replace(InfantMortality$X__7, ":", "Not Available")
InfantMortality$X__9 <- str_replace(InfantMortality$X__9, ":", "Not Available")
InfantMortality$X__11 <- str_replace(InfantMortality$X__11, ":", "Not Available")
InfantMortality$X__13 <- str_replace(InfantMortality$X__13, ":", "Not Available")
InfantMortality$X__15 <- str_replace(InfantMortality$X__15, ":", "Not Available")
InfantMortality$X__17 <- str_replace(InfantMortality$X__17, ":", "Not Available")
InfantMortality$X__19 <- str_replace(InfantMortality$X__19, ":", "Not Available")
InfantMortality$X__21 <- str_replace(InfantMortality$X__21, ":", "Not Available")
InfantMortality$X__23 <- str_replace(InfantMortality$X__23, ":", "Not Available")
InfantMortality


InfantMortality <- InfantMortality[2:nrow(InfantMortality),]
InfantMortality <- InfantMortality[2:nrow(InfantMortality),]
GDPPerCapita <- GDPPerCapita[2:nrow(GDPPerCapita),]
GDPPerCapita <- GDPPerCapita[2:nrow(GDPPerCapita),]
GDPPerCapita
InfantMortality
InfantMortality[!grepl("<NA>", InfantMortality$X__1),]
InfantMortality[!grepl("Not Available", InfantMortality$X__1),]
NewInfantMortality <- InfantMortality[!grepl(":", InfantMortality$`Infant mortality rate`),]
NewInfantMortality <- NewInfantMortality[!grepl(":=not available", NewInfantMortality$`Infant mortality rate`),]
NewInfantMortality
NewInfantMortality <- sqldf("SELECT * FROM NewInfantMortality
                          ORDER BY X__1 ASC 
                          LIMIT 10", row.names = TRUE)
NewInfantMortality

##NewInfantMortality<-InfantMortality[(4:5:6:7:8:9:10:11),(1:2)]

##ShinyAppVisualization
#Population
# Source helper functions -----
source("helpers.R")

# User interface ----
ui <- basicPage(
  plotOutput("plot1", click = "plot_click"),
  verbatimTextOutput("info")
)
# Server logic ----
server <- function(input, output) {
    output$plot1 <- renderPlot({
        ##plot( HumanResourceTech$`Human resources in science and technology (HRST)`, Population$X__1)
        ggplot(NewPopulation, aes(NewPopulation$`Population without the citizenship of the reporting country`, y = NewPopulation$X__1)) + geom_bar(fill = "#0073C2FF", stat = "identity")
    })

    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
}

shinyApp(ui, server)




shinyApp(ui = ui, server = server)

#Pollution
NewPollution
write.csv(NewPollution, file = "NewPollution.csv")
source("helpers.R")
# User interface ----
# User interface ----
ui <- basicPage(
  plotOutput("plot3", click = "plot_click"),
  verbatimTextOutput("info")
)
# Server logic ----
server <- function(input, output) {
    output$plot3 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(data = NewPollution, aes(NewPollution$`Pollutant emissions from transport`, y = NewPollution$X__1)) + geom_histogram(stat = "identity")
    })

    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
}
shinyApp(ui, server)


#InfantMortality
write.csv(NewInfantMortality, file = "NewInfantMortality.csv")
source("helpers.R")
# User interface ----
# User interface ----
ui <- basicPage(
  plotOutput("plot1", click = "plot_click"),
  verbatimTextOutput("info")
)
# Server logic ----
server <- function(input, output) {
    output$plot2 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(NewInfantMortality, aes(NewInfantMortality$`Infant mortality rate`, y = NewInfantMortality$X__1)) + geom_point() + geom_smooth(method = "lm")
    })

    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
}

shinyApp(ui, server)

source("helpers.R")
# User interface ----
# User interface ----
ui <- basicPage(
  plotOutput("plot3", brush = "plot_brush"),
  verbatimTextOutput("info")
  selectInput("Countries", "Countries:", c("Spain",))
)
# Server logic ----
server <- function(input, output) {
    output$plot3 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        ggplot(NewInfantMortality, aes(NewInfantMortality$`Infant mortality rate`, y = NewInfantMortality$X__1)) + geom_point() + geom_smooth(method = "lm")
    })

    output$info <- renderPrint({
        brushedPoints(InfantMortality, input$plot_brush, allRows = TRUE)
    })
}

shinyApp(ui, server)


shinyApp(ui, server)

#Agregating all the plots in one shiny app
EuropeStat <- read.csv("EuropeStat.csv")
EuropeStat
library(shiny)
library(ggplot2)
server <- function(input, output) {
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
}


ui <- fluidPage(
  titlePanel("Countries in Europe"),
  tabsetPanel(
    tabPanel('Panel1', plotOutput('plot1'), verbatimTextOutput("info"), click = "plot_click"),
    tabPanel('Panel2', plotOutput('plot2')),
    tabPanel('Panel3', plotOutput('plot3')),
    tabPanel('Panel4', plotOutput('plot4'))
  )
)


##verbatimTextOutput("info")

# Server logic ----
shinyApp(ui, server)

#MAPFunction
library(shiny)
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

ui <- fluidPage(
  leafletOutput("mymap"),
  p(),
  actionButton("recalc", "New points")
)

server <- function(input, output, session) {

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

shinyApp(ui, server)


