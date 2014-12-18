#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips<-as.factor(NEI$fips)
NEI$SCC<-as.factor(NEI$SCC)
NEI$Pollutant<-as.factor(NEI$Pollutant)
NEI$year<-as.factor(NEI$year)
#===============================Question 1=======================================
#Have total emissions from PM2.5 decreased in the United States from 1999 to 
#2008? Using the base plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

totals<-tapply(NEI$Emissions, NEI$year, sum)

png(filename="plot1.png")
barplot(totals, main="Total PM2.5 Emission From All Sources", xlab="Year", 
        ylab="Tons of PM2.5", col="steelblue")
dev.off()
