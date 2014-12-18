#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips<-as.factor(NEI$fips)
NEI$SCC<-as.factor(NEI$SCC)
NEI$Pollutant<-as.factor(NEI$Pollutant)
NEI$year<-as.factor(NEI$year)
#===================================Question 3==================================
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 
#1999–2008 for Baltimore City? Which have seen increases in emissions from 
#1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

totals.bmore.bytype<-tapply(NEI$Emissions[NEI$fips == 24510], 
                            INDEX=list(NEI$year[NEI$fips==24510], NEI$type[NEI$fips==24510]), sum)
totals3.df<-data.frame(totals=c(totals.bmore.bytype), 
                       type=rep(c("Non-Road", "Nonpoint", "On-Road", "Point"), each=4),
                       year=rep(c(1999, 2002, 2005, 2008), times=4))

png(filename="plot3.png")
qplot(year, totals, data=totals3.df, facets=.~type, geom="bar", stat="identity")
dev.off()
