#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips<-as.factor(NEI$fips)
NEI$SCC<-as.factor(NEI$SCC)
NEI$Pollutant<-as.factor(NEI$Pollutant)
NEI$year<-as.factor(NEI$year)
#==================================Question 5===================================
#How have emissions from motor vehicle sources changed from 1999–2008 in 
#Baltimore City? 

#I assumed that On-road sources would cover motor vehicles

totals.vehicle<-tapply(NEI$Emissions[NEI$type == "ON-ROAD" & NEI$fips == 24510], 
                       NEI$year[NEI$type == "ON-ROAD" & NEI$fips == 24510], sum)


png(filename="plot5.png")
barplot(totals.vehicle, main="Total PM2.5 Emission From Motor Vehicle Sources in Baltimore", xlab="Year", 
        ylab="Tons of PM2.5", col="steelblue")
dev.off()
