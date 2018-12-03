###################################################
##########       Data preprocessing      ##########
###################################################

#gdp <- read.csv(file = "Life expectancy.csv")
#gdp <- melt(gdp, id.vars = c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code"))
#colnames(gdp) <- c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code", "Year", "Value")
#gdp <- gdp[gdp$Year != "X",]
#gdp$Year <- substr(gdp$Year, 2, 5)
#write.csv(gdp, file = "Life expectancy (melted).csv")

#countries <- c("Belgium", "Bulgaria", "Czech Republic", "Denmark", "Germany", "Estonia", "Ireland", "Greece", "Spain", "France", "Croatia", "Italy", "Cyprus", "Latvia", "Lithuania", "Luxembourg", "Hungary", "Malta", "Netherlands", "Austria", "Poland", "Portugal", "Romania", "Slovenia", "Slovak Republic", "Finland", "Sweden", "United Kingdom")

#gdp <- read.csv(file = "Life expectancy.csv", header = TRUE, sep = ",")
#gdp <- gdp[gdp$Country.Name %in% countries,]
#write.csv(gdp, file = "Life expectancy (2).csv")

#EuropeStat <- read.csv("EuropeStat.csv")
#EuropeStat