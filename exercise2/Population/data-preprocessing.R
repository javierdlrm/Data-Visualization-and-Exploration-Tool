###################################################
##########       Data preprocessing      ##########
###################################################

population <- read.csv(file = "Population.csv")
population <- melt(population, id.vars = c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code"))
colnames(population) <- c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code", "Year", "Value")
population <- population[population$Year != "X",]
population$Year <- substr(population$Year, 2, 5)
write.csv(population, file = "Population (melted).csv")

dataset <- merge(population, gdp)

#countries <- c("Belgium", "Bulgaria", "Czech Republic", "Denmark", "Germany", "Estonia", "Ireland", "Greece", "Spain", "France", "Croatia", "Italy", "Cyprus", "Latvia", "Lithuania", "Luxembourg", "Hungary", "Malta", "Netherlands", "Austria", "Poland", "Portugal", "Romania", "Slovenia", "Slovak Republic", "Finland", "Sweden", "United Kingdom")

#population <- read.csv(file = "API_SP.POP.TOTL_DS2_en_csv_v2_10224786.csv", header = TRUE, sep = "\t")
#population <- population[population$Country.Name %in% countries,]
#write.csv(population, file = "Population.csv")


Population <- read_excel("Population.xls")

# Cleaning of Population Dataset

# Trimming whitespaces and replacing missing values

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

# Interpretation of columns and removing unnecessory values

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

# Interpreting rows

Population <- Population[2:nrow(Population),]
Population <- Population[2:nrow(Population),]
Population <- Population[2:nrow(Population),]
Population

# VisualPlot after cleaning for Percentage popuation in 2010

Population <- Population[!grepl(":", Population$`Population without the citizenship of the reporting country`),]
Population[!grepl("<NA>", Population$X__1),]
Population[!grepl("Not Available", Population$X__1),]
Population

NewPopulation <- sqldf("SELECT * FROM Population ORDER BY X__1 ASC LIMIT 10", row.names = TRUE)
NewPopulation
##NewPopulation<-Population[(4:5:6:7:8:9:10:11),(1:2)]
#NewPopulation
