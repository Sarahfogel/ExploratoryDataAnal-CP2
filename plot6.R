#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips<-as.factor(NEI$fips)
NEI$SCC<-as.factor(NEI$SCC)
NEI$Pollutant<-as.factor(NEI$Pollutant)
NEI$year<-as.factor(NEI$year)

#==============================Question 6 ======================================
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#I assumed that On-road sources would cover motor vehicles


Baltimore<-tapply(NEI$Emissions[NEI$type == "ON-ROAD" & NEI$fips == 24510], 
                  NEI$year[NEI$type == "ON-ROAD" & NEI$fips == 24510], sum)

Los.Angeles<-tapply(NEI$Emissions[NEI$type == "ON-ROAD" & NEI$fips == "06037"], 
                    NEI$year[NEI$type == "ON-ROAD" & NEI$fips == "06037"], sum)


table.bmore.la<-rbind(Baltimore, Los.Angeles)

png(filename="plot6.png", height=480, width=600, units="px")
par(mfrow=c(1,2))
barplot(table.bmore.la, beside=T, main="PM2.5 Emission From Motor Vehicles", xlab="Year", 
        ylab="Tons of PM2.5", col=c("steelblue", "darkolivegreen3"), ylim=c(0, 5000))
legend(legend=rownames(table.bmore.la), x="topleft", fill=c("steelblue", "darkolivegreen3"))
barplot(height=c(abs(Baltimore[4]-Baltimore[1]), abs(Los.Angeles[4]-Los.Angeles[1])),
        main="Absolute Difference from 1999 to 2008", col=c("steelblue", "darkolivegreen3"),
        xlab="City", xaxt="n")
axis(1, at=c(.7, 1.9) ,labels=c("Baltimore", "Los Angeles"), tick=F)
dev.off()

