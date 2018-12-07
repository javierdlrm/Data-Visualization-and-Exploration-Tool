###################################################
##########           Global        ################
###################################################

values <- reactiveValues()

# Countries

countries <- c("Belgium", "Bulgaria", "Czech Republic", "Denmark", "Germany", "Estonia", "Ireland", "Greece", "Spain", "France", "Croatia", "Italy", "Cyprus", "Latvia", "Lithuania", "Luxembourg", "Hungary", "Malta", "Netherlands", "Austria", "Poland", "Portugal", "Romania", "Slovenia", "Slovak Republic", "Finland", "Sweden", "United Kingdom")
countries_selected <- countries

values$countries <- countries
values$countries_selected <- countries_selected

# Years

years <- c(2000:2014)
years_selected <- years
year <- years[1]

values$years <- years
values$years_selected <- years_selected
values$year <- year

# Europe_Stats

europe_stats <- read.csv(file = "Europe statistics.csv")
colnames(europe_stats) <- c("country.name", "country.code", "year", "co2.emission", "co2.emission.pc", "co2.emission.level", "gdp.pc", "health.gdp", "life.exp", "infant.mort", "infant.deaths", "population", "area", "size")
europe_stats$country.name <- as.factor(europe_stats$country.name)
europe_stats$country.code <- as.factor(europe_stats$country.code)
europe_stats$co2.emission.level <- as.factor(europe_stats$co2.emission.level)
europe_stats$size <- as.factor(europe_stats$size)

values$europe_stats <- reactive({
    data <- europe_stats[europe_stats$country.name %in% values$countries_selected,]
    return(data)
})

values$europe_stats_pca <- reactive({
    req(values$europe_stats)
    data <- values$europe_stats()[values$europe_stats()$year %in% values$years_selected,]
    data <- select(data, c(4, 7, 8, 9, 10, 11, 12))
    return(data)
})