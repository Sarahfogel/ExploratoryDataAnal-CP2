#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips<-as.factor(NEI$fips)
NEI$SCC<-as.factor(NEI$SCC)
NEI$Pollutant<-as.factor(NEI$Pollutant)
NEI$year<-as.factor(NEI$year)
#=================================Question 4=======================================    
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?

levels(SCC$EI.Sector)[grep("Coal", levels(SCC$EI.Sector))]

coal.index<-levels(SCC$SCC)[grep("Coal", levels(SCC$EI.Sector))]

totals.coal<-tapply(NEI$Emissions[NEI$SCC %in% coal.index], NEI$year[NEI$SCC %in% coal.index], sum)

png(filename="plot4.png")
barplot(totals.coal, main="Total PM2.5 Emission From Coal Sources", xlab="Year", 
        ylab="Tons of PM2.5", col="steelblue")
dev.off()
