###################################################
#########       Clustering Module          ########
###################################################

clustering_path <- "Clustering/"

# Data preprocessing

source(str_c(clustering_path, "data-preprocessing.R"), local = TRUE)

# UI

clustering_ui <- function(id) {
    ns <- NS(id)
    tabPanel(
        title = "Clustering",
        column(width = 2, class = "sidebar", box(width = 12, h4(class = "accent-color", "Options"),
            h5("General"),
            HTML("<label>Countries: </label>"),
            actionButton(ns("countries_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("countries_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('countries'), NULL, choices = countries, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a country name, e.g. Spain', maxItems = 28)),
            HTML("<label>Years: </label>"),
            actionButton(ns("years_reset"), class = "button-option btn btn-link", "Reset"),
            actionButton(ns("years_select_all"), class = "button-option btn btn-link", "Select all"),
            selectizeInput(ns('years'), NULL, choices = years, selected = NULL, multiple = TRUE,
                           options = list(placeholder = 'Type a year, e.g. 2001', maxItems = 15)),
            h5("Clustering"),
            selectizeInput(ns('plot_data_type'), "Source:", choices = c("Dataset", "PCA"), selected = "Dataset"),
            sliderInput(ns("n_clusters"), "Nº clusters:", min = 3, max = 7, value = 3, step = 1))),
        column(width = 10, class = "content", box(width = 12,
            h4("Clustering"),
            plotOutput(ns("plot.kmeans")),
            h4("Principal component analysis & Goodman Kruskal"),
            box(width = 4, plotOutput(ns("plot.fviz.pca_var"))),
            box(width = 4, plotOutput(ns("plot.fviz.eig"))),
            box(width = 4, plotOutput(ns("plot.goodman.kruskal"))))))
}

# Server

clustering_server <- function(input, output, session) {

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

    # plots

    output$plot.fviz.pca_var <- renderPlot({
        req(values$europe_stats_pca)
        
        data_pca <- prcomp(values$europe_stats_pca(), scale. = T)
        return(fviz_pca_var(data_pca))
    })

    output$plot.fviz.eig <- renderPlot({
        req(values$europe_stats_pca)

        data_pca <- prcomp(values$europe_stats_pca(), scale. = T)
        return(fviz_eig(data_pca, addlabels = TRUE, ylim = c(0, 50)))
    })

    output$plot.goodman.kruskal <- renderPlot({
        req(values$europe_stats_pca)

        gkdata <- GKtauDataframe(values$europe_stats_pca())
        return(plot(gkdata, corrColors = "blue"))
    })

    output$plot.kmeans <- renderPlot({
        req(values$europe_stats_pca)
        req(input$n_clusters)
        req(input$plot_data_type)

        palette(alpha(brewer.pal(9, 'Set1'), 0.5))

        if (input$plot_data_type == "Dataset") {
            k <- kmeans(values$europe_stats_pca(), input$n_clusters, nstart = 25, iter.max = 1000)
            plot(values$europe_stats_pca(), col = k$clust, pch = 9)
            #clusplot(values$europe_stats_pca(), k$cluster, color = TRUE, shade = TRUE, lines = 0)
        } else {
            data_pca <- prcomp(values$europe_stats_pca(), scale. = T)
            comp <- data.frame(data_pca$x[, 1:3])
            k <- kmeans(comp, input$n_clusters, nstart = 25, iter.max = 1000)
            plot(comp, col = k$clust, pch = 9)
            #clusplot(comp, k$cluster, color = TRUE, shade = TRUE, lines = 0)
        }
    })
}
