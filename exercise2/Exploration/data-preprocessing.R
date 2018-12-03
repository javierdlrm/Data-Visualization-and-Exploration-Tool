###################################################
##########       Data preprocessing      ##########
###################################################

#co2 <- read.csv(file = "../CO2 emissions/CO2 emissions (melted).csv")
#co2 <- co2[, c(2, 3, 6, 7)]
#co2_pc <- read.csv(file = "../CO2 emissions/CO2 emissions per capita (melted).csv")
#co2_pc <- co2_pc[, c(2, 3, 6, 7)]

#gdp <- read.csv(file = "../Europe stats/GDP (current US$) (melted).csv")
#gdp <- gdp[, c(2, 3, 6, 7)]
#gdp_pc <- read.csv(file = "../Europe stats/GDP (per capita) (melted).csv")
#gdp_pc <- gdp_pc[, c(2, 3, 6, 7)]
#life_expectancy <- read.csv(file = "../Europe stats/Life expectancy (melted).csv")
#life_expectancy <- life_expectancy[, c(2, 3, 6, 7)]

#infant_mortality_rates <- read.csv(file = "../Infant mortality/Infant mortality rates (melted).csv")
#infant_mortality_rates <- infant_mortality_rates[, c(2, 3, 6, 7)]

#population <- read.csv(file = "../Population/Population (melted).csv")
#population <- population[, c(2, 3, 6, 7)]

#columns <- c("Country.Name", "Country.Code", "Year")
#dataset <- merge(co2, co2_pc, by = columns)
#dataset <- merge(dataset, gdp, by = columns)
#dataset <- merge(dataset, gdp_pc, by = columns)
#dataset <- merge(dataset, life_expectancy, by = columns)
#dataset <- merge(dataset, infant_mortality_rates, by = columns)
#dataset <- merge(dataset, population, by = columns)

#write.csv(dataset, "Europe statistics.csv")

europe_stats <- read.csv(file = "Europe statistics.csv")

boxplot(europe_stats$Population ~ europe_stats$Year, data = europe_stats)