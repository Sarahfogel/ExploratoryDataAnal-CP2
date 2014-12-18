#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips<-as.factor(NEI$fips)
NEI$SCC<-as.factor(NEI$SCC)
NEI$Pollutant<-as.factor(NEI$Pollutant)
NEI$year<-as.factor(NEI$year)
#=================================Question 2=====================================
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == 24510) from 1999 to 2008? Use the base plotting system to make a 
#plot answering this question.


totals.bmore<-tapply(NEI$Emissions[NEI$fips == 24510], NEI$year[NEI$fips==24510], sum)

png(filename="plot2.png")
barplot(totals.bmore, main="Total PM2.5 Emission From All Sources in Baltimore", xlab="Year", 
        ylab="Tons of PM2.5", col="steelblue")
dev.off()
