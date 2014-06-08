#setwd("C:\\Users\\Alejandro Crema\\Desktop\\Soporte\\Data Science\\Exploratory Data Analysis\\Week 1")

#I set the Class to character
myClass= c(Date="character",Time="character",Global_active_power="character",Voltage="character",Global_intensity="character",Sub_metering_1="character",Sub_metering_2="character",Sub_metering_3="character")

#Read the data from .txt file it has header, separator is ; and decimal is .
data<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".",colClasses=myClass) 

#I change my dates and times format
#all<-strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")

dates<-as.Date(data$Date, format="%d/%m/%Y")

#Setting new class
data$Date<-dates

#Logical vector from 01-02 to 02-02
clean<-(data$Date=="2007-02-02"|data$Date=="2007-02-01")&data$Global_reactive_power!="?"

#Tidy Data
data<-data[clean,]

#Converting Date and Time to format using strptime
all<-strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S",tz = "EST5EDT")

#Changing class from columns 3 to 9
for(i in 3:9){
  data[,i]<-as.numeric(data[,i])  
}

#Histogram from plot2
x<-data$Sub_metering_1
y<-data$Sub_metering_2
z<-data$Sub_metering_3

#opening plot    


#Drawing lines
plot(all,x,type="n",xlab="",ylab="Energy sub metering")
lines(all,x,col="black")
lines(all,y,col="red")
lines(all,z,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),cex=0.5,y.intersp=0.8)


dev.copy(png,file="plot3.png",height=480,width=480)
dev.off()
