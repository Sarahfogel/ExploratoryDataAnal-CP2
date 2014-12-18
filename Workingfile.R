# Begin with the data downloaded and unzipped into your working director
#fips: A five-digit number (represented as a string) indicating the U.S. county
#
#SCC: The name of the source as indicated by a digit string (see source code classification table)
#
#Pollutant: A string indicating the pollutant
#
#Emissions: Amount of PM2.5 emitted, in tons
#
#type: The type of source (point, non-point, on-road, or non-road)
#
#year: The year of emissions recorded


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

    
#=================================Question 2=====================================
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
    #(fips == 24510) from 1999 to 2008? Use the base plotting system to make a 
    #plot answering this question.
    
    
    totals.bmore<-tapply(NEI$Emissions[NEI$fips == 24510], NEI$year[NEI$fips==24510], sum)
    
    png(filename="plot2.png")
    barplot(totals.bmore, main="Total PM2.5 Emission From All Sources in Baltimore", xlab="Year", 
            ylab="Tons of PM2.5", col="steelblue")
    dev.off()

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
    
    
#==================================Question 5===================================
#How have emissions from motor vehicle sources changed from 1999–2008 in 
    #Baltimore City? 

    
    totals.vehicle<-tapply(NEI$Emissions[NEI$type == "ON-ROAD" & NEI$fips == 24510], 
                        NEI$year[NEI$type == "ON-ROAD" & NEI$fips == 24510], sum)
    
    
    png(filename="plot5.png")
    barplot(totals.vehicle, main="Total PM2.5 Emission From Motor Vehicle Sources in Baltimore", xlab="Year", 
            ylab="Tons of PM2.5", col="steelblue")
    dev.off()
    
    
    
#==============================Question 6 ======================================
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
    #from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
    #Which city has seen greater changes over time in motor vehicle emissions?
    
    
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
    
    