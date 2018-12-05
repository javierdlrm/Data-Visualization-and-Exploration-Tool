###################################################
##########       Data preprocessing      ##########
###################################################

#co2 <- read.csv(file = "CO2 emissions per capita (melted).csv")
#ggplot(co2, aes(x = co2$Year, y = co2$Value, group = co2$Country.Name, label = co2$Country.Name)) +
    #geom_line(aes(colour = co2$Country.Name)) +
    #geom_point(aes(colour = co2$Country.Name)) +
    #geom_dl(aes(label = co2$Country.Name, colour = co2$Country.Name), method = list(dl.trans(x = x + .2), "last.points"))

#co2 <- read.csv(file = "CO2 emissions per capita.csv")
#co2 <- melt(co2, id.vars = c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code"))
#colnames(co2) <- c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code", "Year", "Value")
#co2 <- co2[co2$Year != "X",]
#co2$Year <- substr(co2$Year, 2, 5)

#write.csv(co2, file = "CO2 emissions per capita (melted).csv")

#Pollution <- read_excel("Pollution_cleaned.xls")
#Pollution <- melt(Pollution, id.vars = c("Country"))
#Pollution <- Pollution[Pollution$Country != "EU (28 countries)",]
#colnames(Pollution) <- c("Country", "Year", "Emission")

#co2.emissions <- read.csv(file = "Emission per capita.csv", header = TRUE, sep = ",")
#co2.emissions <- co2.emissions[co2.emissions$Country.Name %in% countries,]
#write.csv(co2.emissions, file = "CO2 Emissions per capita.csv")

#ggplot(data = Pollution, aes(x = Pollution$Year, y = Pollution$Emission, group = Pollution$Country)) + geom_line(aes(colour = Pollution$Country)) + geom_point(aes(color = Pollution$Country))

## Cleaning of Pollution Dataset
#Pollution <- read_excel("Pollution.xls")
#Pollution
#class(Pollution)
#dim(Pollution)

## Summarizing the dataset
#summary(Pollution)

#Pollution <- Pollution[,2:2:ncol(Pollution)-1]

#Pollution$X__1 <- str_replace(Pollution$X__1, ":", "Not Available")
#Pollution
#Pollution$X__2 <- str_replace(Pollution$X__2, ":", "Not Available")
#Pollution$X__3 <- str_replace(Pollution$X__3, ":", "Not Available")
#Pollution$X__4 <- str_replace(Pollution$X__4, ":", "Not Available")
#Pollution$X__5 <- str_replace(Pollution$X__5, ":", "Not Available")
#Pollution$X__6 <- str_replace(Pollution$X__6, ":", "Not Available")
#Pollution$X__7 <- str_replace(Pollution$X__7, ":", "Not Available")
#Pollution
#Pollution$X__8 <- str_replace(Pollution$X__8, ":", "Not Available")
#Pollution$X__9 <- str_replace(Pollution$X__9, ":", "Not Available")
#Pollution$X__10 <- str_replace(Pollution$X__10, ":", "Not Available")
#Pollution$X__11 <- str_replace(Pollution$X__11, ":", "Not Available")
#Pollution$X__12 <- str_replace(Pollution$X__12, ":", "Not Available")
#Pollution$X__13 <- str_replace(Pollution$X__13, ":", "Not Available")
#Pollution$X__14 <- str_replace(Pollution$X__14, ":", "Not Available")
#Pollution$X__15 <- str_replace(Pollution$X__15, ":", "Not Available")
#Pollution$X__16 <- str_replace(Pollution$X__16, ":", "Not Available")
#Pollution$X__17 <- str_replace(Pollution$X__17, ":", "Not Available")
#Pollution$X__18 <- str_replace(Pollution$X__18, ":", "Not Available")
#Pollution$X__19 <- str_replace(Pollution$X__19, ":", "Not Available")
#Pollution$X__20 <- str_replace(Pollution$X__20, ":", "Not Available")
#Pollution$X__21 <- str_replace(Pollution$X__21, ":", "Not Available")
#Pollution$X__22 <- str_replace(Pollution$X__22, ":", "Not Available")
#Pollution$X__23 <- str_replace(Pollution$X__23, ":", "Not Available")
#Pollution$X__24 <- str_replace(Pollution$X__24, ":", "Not Available")
#Pollution$X__25 <- str_replace(Pollution$X__25, ":", "Not Available")
#Pollution$X__27 <- str_replace(Pollution$X__27, ":", "Not Available")
#Pollution$X__29 <- str_replace(Pollution$X__29, ":", "Not Available")
#Pollution$X__31 <- str_replace(Pollution$X__31, ":", "Not Available")
#Pollution$X__33 <- str_replace(Pollution$X__33, ":", "Not Available")
#Pollution$X__35 <- str_replace(Pollution$X__35, ":", "Not Available")
#Pollution$X__37 <- str_replace(Pollution$X__37, ":", "Not Available")
#Pollution$X__39 <- str_replace(Pollution$X__39, ":", "Not Available")
#Pollution$X__41 <- str_replace(Pollution$X__41, ":", "Not Available")
#Pollution$X__43 <- str_replace(Pollution$X__43, ":", "Not Available")
#Pollution$X__45 <- str_replace(Pollution$X__45, ":", "Not Available")
#Pollution$X__47 <- str_replace(Pollution$X__47, ":", "Not Available")

## Removing unnecessory columns

#Pollution$X__2 = NULL
#Pollution$X__4 = NULL
#Pollution$X__6 = NULL
#Pollution$X__8 = NULL
#Pollution$X__10 = NULL
#Pollution$X__12 = NULL
#Pollution$X__14 = NULL
#Pollution$X__16 = NULL
#Pollution$X__18 = NULL
#Pollution$X__20 = NULL
#Pollution$X__22 = NULL
#Pollution$X__24 = NULL
#Pollution$X__26 = NULL
#Pollution$X__28 = NULL
#Pollution$X__30 = NULL
#Pollution$X__32 = NULL
#Pollution$X__34 = NULL
#Pollution$X__36 = NULL
#Pollution$X__38 = NULL
#Pollution$X__40 = NULL
#Pollution$X__42 = NULL
#Pollution$X__44 = NULL
#Pollution$X__46 = NULL
#Pollution$X__48 = NULL
#Pollution$X__50 = NULL
#Pollution$X__52 = NULL
#Pollution$X__54 = NULL

## Interpreting Rows

#Pollution <- Pollution[3:nrow(Pollution),]

## VisualPlot after cleaning for Percentage popuation in 2010

#NewPollution <- Pollution[!grepl(":=not available", Pollution$`Pollutant emissions from transport`),]
#NewPollution <- Pollution[!grepl(":", Pollution$`Pollutant emissions from transport`),]
#NewPollution <- sqldf("SELECT * FROM NewPollution ORDER BY X__1 ASC LIMIT 10", row.names = TRUE)

## Aggregation of two dataframes
## Checking Dimensions

#dim(data2)
#dim(Pollution)
