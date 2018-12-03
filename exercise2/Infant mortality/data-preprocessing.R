###################################################
##########       Data preprocessing      ##########
###################################################

#infant_mortality_rates <- read.csv(file = "Infant mortality rates.csv")
#infant_mortality_rates <- melt(infant_mortality_rates, id.vars = c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code"))
#colnames(infant_mortality_rates) <- c("Country.Name", "Country.Code", "Indicator.Name", "Indicator.Code", "Year", "Value")
#infant_mortality_rates <- infant_mortality_rates[infant_mortality_rates$Year != "X",]
#infant_mortality_rates$Year <- substr(infant_mortality_rates$Year, 2, 5)
#write.csv(infant_mortality_rates, file = "Infant mortality rates (melted).csv")


#countries <- c("Belgium", "Bulgaria", "Czech Republic", "Denmark", "Germany", "Estonia", "Ireland", "Greece", "Spain", "France", "Croatia", "Italy", "Cyprus", "Latvia", "Lithuania", "Luxembourg", "Hungary", "Malta", "Netherlands", "Austria", "Poland", "Portugal", "Romania", "Slovenia", "Slovak Republic", "Finland", "Sweden", "United Kingdom")

#infant_mortality_rates <- read.csv(file = "API_SP.DYN.IMRT.IN_DS2_en_csv_v2_10226383.csv", header = TRUE, sep = "\t")
#infant_mortality_rates <- infant_mortality_rates[infant_mortality_rates$Country.Name %in% countries,]
#write.csv(infant_mortality_rates, file = "Infant Mortality Rates.csv")

#InfantMortality <- read_excel("InfantMortality.xls")
#GDPPerCapita <- read_excel("GDPPerCapita.xls")

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
NewInfantMortality <- sqldf("SELECT * FROM NewInfantMortality ORDER BY X__1 ASC LIMIT 10", row.names = TRUE)
NewInfantMortality

##NewInfantMortality<-InfantMortality[(4:5:6:7:8:9:10:11),(1:2)]