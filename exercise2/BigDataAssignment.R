library(corrplot)
library(FactoMineR)
library(factoextra)

EuropeStatistics <- read.csv(file = "Europe Statistics.csv", header = TRUE, sep = ",")
Europe_df <- EuropeStatistics
Europe_df$Country.Code <- NULL
Europe_df$Country.Name <- NULL
Europe_df$Size <- NULL
Europe_df$CO2.Emission.Level <- NULL
EuropeStat_PCA_r <- prcomp(Europe_df, scale. = T)
Europe_df
EuropeStat_PCA_r

PC <- EuropeStat_PCA_r$rotation[1:7, 1:4]
chisq.test(Europe_df$CO2.Emission, Europe_df$Infant.Mort, correct = FALSE)

PC
plot(EuropeStat_PCA_r, choix = "var")
fviz_pca_var(EuropeStat_PCA_r)
EuropeStat_PCA_r$center
eig.val.eu <- get_eigenvalue(EuropeStat_PCA_r)
eig.val.eu
fviz_eig(EuropeStat_PCA_r, addlabels = TRUE, ylim = c(0, 50))
chisq.test(Europe_df$GDP.PC, EuropeStatistics$Population, correct = FALSE)
chisq.test(Europe_df$Infant.Mort, EuropeStatistics$Population, correct = FALSE)

library(GoodmanKruskal)
Attributes <- c("CO2.Emission", "Infant.Mort", "Population")
DataFrame <- subset(Europe_df, select = Attributes)
Final <- GKtauDataframe(DataFrame)
plot(Final, corrColors = "blue")
fit <- kmeans(Europe_df, 5)
library(cluster)
clusplot(Europe_df, fit$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0)




#Agregating all the plots in one shiny app
EuropeStatistics <- read.csv("Europe Statistics.csv")
library(reshape2)
library(shiny)
library(ggplot2)
server <- function(input, output) {
    output$plot1 <- renderPlot({
        #updateSelectizeInput(session, 'Country', choices = EuropeStat$Country, server = TRUE)
        #cat(file = stderr(), "Country Graph", input$Country, "", "\n")
        #filtered <- EuropeStatistics[EuropeStatistics$Country.Name == input$Country,]
        #cat(file = stderr(), "filtered ", nrow(filtered), "", "\n")
        #return(ggplot(filtered, aes(x = Country.Name, y = GDP.PC, fill = Year)) + geom_boxplot(width = 1))
    })
    output$info <- renderText({
        #paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
    output$plot2 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        #updateSelectizeInput(session, 'Country', choices = EuropeStat$Country, server = TRUE)
        #cat(file = stderr(), "Country Graph", input$Country, "", "\n")
        #filtered <- EuropeStatistics[EuropeStatistics$Country.Name == input$Country,]
        #cat(file = stderr(), "filtered ", nrow(filtered), "", "\n")
        #return(ggplot(filtered, aes(x = Year, y = GDP.PC, color = Country.Name)) + geom_point())
    })
    output$plot3 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        #return(ggplot(EuropeStatistics, aes(x = EuropeStatistics$Year, y = EuropeStatistics$Infant.Mort, color = EuropeStatistics$Country.Name)) + geom_point())
    })
    output$plot4 <- renderPlot({
        ##plot( InfantMortality`, Population$X__1)
        #cat(file = stderr(), "Country Graph", input$Country, "", "\n")
        #filtered <- EuropeStatistics[EuropeStatistics$Country.Name == input$Country,]
        #cat(file = stderr(), "filtered ", nrow(filtered), "", "\n")
        #ggplot(data = filtered, aes(x = Year, y = Population)) + geom_histogram(stat = "identity")
    })
    #output$plot5 <- renderPlot({
        #return(ggplot(data = EuropeStat, aes(x=EuropeStat$Country, y=EuropeStat$GDP)) + geom_bar(stat = "identity"))
    #})
    output$plot.tile.infant_mort <- renderPlot({
        return(ggplot(data = values$europe_stats, aes(x = country.name, y = co2.emission.level)) + geom_tile(aes(fill = infant.mort)))
    }
  )
    output$plot7 <- renderPlot({
        return(ggplot(data = EuropeStatistics, aes(x = EuropeStatistics$Country.Name, y = EuropeStatistics$Year)) + geom_tile(aes(fill = EuropeStatistics$Population), color = "white") + scale_fill_gradient(low = "white", high = "steelblue") + ylab("Years") + xlab("Countries") + theme(legend.title = element_text(size = 10), legend.text = element_text(size = 12), plot.title = element_text(size = 16), axis.title = element_text(size = 14, face = "bold"), axis.text.x = element_text(angle = 90, hjust = 1)))
    }
  )
    output$plot8 <- renderPlot({
        return(ggplot(data = EuropeStatistics, aes(x = EuropeStatistics$Country.Name, y = EuropeStatistics$Year)) + geom_point(aes(size = EuropeStatistics$CO2.Emission))
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
  selectizeInput('Country', "Countries: Filteration for UnEmployment, GDP and Population growth", choices = EuropeStatistics$Country, options = list(
    placeholder = 'Type a Country name, e.g. Spain', maxOptions = 10)
  ),
  titlePanel("Countries in Europe"),
  tabsetPanel(
    tabPanel('Panel1', plotOutput('plot1'), verbatimTextOutput("info"), click = "plot_click"),
    tabPanel('Panel2', plotOutput('plot2')),
    tabPanel('Panel3', plotOutput('plot3')),
    tabPanel('Panel4', plotOutput('plot4')),
#tabPanel('Panel5', plotOutput('plot5')),#verbatimTextOutput("info"), click = "plot_click")
    tabPanel('Panel6', plotOutput('plot6')),
    tabPanel('Panel7', plotOutput('plot7')),
    tabPanel('Panel8', plotOutput('plot8'))
  )
)
shinyApp(ui, server)

cou <- countries[1:6]
data <- europe_stats[europe_stats$country.name %in% cou, ]
ggpairs(~europe_stats$infant.deaths + europe_stats$co2.emission.pc + europe_stats$gdp.pc | europe_stats$siz, data = data, cardinality_threshold = 28)

# Use of the mtcars data proposed by R
data = cor(europe_stats)

# Build a Pannel of 100 colors with Rcolor Brewer
my_colors <- brewer.pal(5, "Spectral")
my_colors = colorRampPalette(my_colors)(100)

# Order the correlation matrix
ord <- order(data[1,])
data_ord = data[ord, ord]
plotcorr(data_ord, col = my_colors[data_ord * 50 + 50], mar = c(1, 1, 1, 1))

# Packages
library(car)
library(RColorBrewer)

# Let's use the car dataset proposed by R
data = mtcars

# Make the plot
my_colors <- brewer.pal(nlevels(as.factor(data$europe_stats$population)), "Set2")
scatterplotMatrix(~europe_stats$co2.emission.pc + europe_stats$infant.mort + europe_stats$gdp.pc | europe_stats$population, data = data, reg.line = "", smoother = "", col = my_colors, smoother.args = list(col = "grey"), cex = 1.5, pch = c(15, 16, 17), main = "Scatter plot with Three Cylinder Options")

treemap(europe_stats,
        index = c("country.name", "year"),
        vSize = "infant.deaths",
        type = "manual",
        palette = my_colors,
        position.legend = "right",
        fontsize.title = 14)
