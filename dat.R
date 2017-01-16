## Download data file

fileURL<- "http://www.journalofaccountancy.com/content/dam/jofa/issues/2017/jan/general-ledger-collins.xlsx"
destfile <- "./data.xlsx"
##download.file("http://www.journalofaccountancy.com/content/dam/jofa/issues/2017/jan/general-ledger-collins.xlsx", 
##              "t.xlsx", method = "curl")
if (!file.exists(destfile)) {
  setInternet2(TRUE)
  download.file(fileURL ,destfile,method="curl") }
### http://www.journalofaccountancy.com/issues/2017/jan/general-ledger-data-mining.html
install.packages("compare")
library(compare)
## Read in data and convert xlsx to csv 
install.packages("rio")
install.packages("xlsx")
library(xlsx)
library(rio)
dat<-read.xlsx2("data.xlsx", sheetName = "QuickBooks GL Report", colClasses = c("character","character","character","character","character","character","character","Date"))
## If you open the xlsx file, the dates are wrong!
convert("data.xlsx", "dat.csv")
dat<-read.csv("dat.csv")
## No problems with dates in csv format
## Check percentage of NAs in test set
colMeans(is.na(dat))*100
## remove columns with greater than 99% NAs 
datNoNA <- dat[, -which(colMeans(is.na(dat)) > 0.99)]
## remove rows with greater than 99% NAs 
datNoNA2 <- datNoNA[-which(rowMeans(is.na(datNoNA)) > 0.99), ]
## copy down names from column 1
install.packages("tidyr")
library(tidyr)
datFinal<-datNoNA2 %>% fill(NA..1)

datNoNA3<-datNoNA2 %>% fill(NA..1)

## remove rows with zero balance
datNoNA4 <- datNoNA3[-which(datNoNA3$Balance==0), ]
## remove rows without dates

## remove rows without dates
datFinal <- datNoNA4[-which(is.na(datNoNA4$Date)), ]
colMeans(is.na(datFinal))*100

##rename 1st column
names(datFinal)[names(datFinal)=="NA..1"] <- "Account"

## save "scrubbed" data as xlsx
write.xlsx(datFinal, "scrubbed.xlsx", sheetName = "Sheet1")

install.packages("lubridate")
library(lubridate)

## stacked bar in ggplot2
##install.packages("ggplot2")
##library(ggplot2)
##ggplot(data = datFinal, aes(x = month(datFinal$Date), y = Debit, fill = Account)) + 
##  geom_bar(stat = "identity")
install.packages("plotly")
library(plotly)
## stacked bar in plotly
mon<-month(datFinal$Date)


#Static plot of debits and credits
bcd<-p <- plot_ly(datFinal, x = ~mon, y = ~Debit, type = 'bar', name = 'Debits') %>%
  add_trace(y = ~Credit, name = 'Credits') %>%
  layout(title = "2018 Credits and Debits by month", yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
bcd

## Soon2B reactive plot: Debit bar chart with threshold slider
d1k<-datFinal[which(datFinal$Debit > 1000),]
bd <- plot_ly(d1k, x = ~month(d1k$Date), y = ~Debit, type = 'bar', name = 'Debits', color = ~Account) %>%
    layout(title = "2018 Debits by month", yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
bd
## Soon2B reactive plot: Credit bar chart with threshold slider
c1k<-datFinal[which(datFinal$Credit > 1000),]
bc <- plot_ly(c1k, x = ~month(c1k$Date), y = ~Credit, type = 'bar', name = 'Credits', color = ~Account) %>%
    layout(title = "2018 Credits by month", yaxis = list(title = 'Dollars'), xaxis = list(title = "Month"), barmode = 'stack')
bc
## Soon2B reactive plot: Credit pie chart with threshold slider
pc <- plot_ly(c1k, labels = ~Account, values = ~Credit, type = 'pie') %>%
  layout(title = 'Credits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
pc

## Soon2B reactive plot: Debit pie chart with threshold slider
pd <- plot_ly(d1k, labels = ~Account, values = d1k$Debit, type = 'pie') %>%
  layout(title = 'Debits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
pd
## Soon2B reactive plot: Debit pie chart with month slider
dmon<-d1k[which(month(d1k$Date)==1),]
pdJan <- plot_ly(dmon, labels = ~Account, values = dmon$Debit, type = 'pie') %>%
  layout(title = 'Debits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
pdJan

## Soon2B reactive plot: Debit pie chart with month slider
cmon<-c1k[which(month(c1k$Date)==1),]
pcJan <- plot_ly(cmon, labels = ~Account, values = cmon$Credit, type = 'pie') %>%
  layout(title = 'Crebits',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
pcJan

##pcd <- plot_ly() %>%
##  add_pie(data = datFinal, labels = ~Account, values = ~Credit,
##          name = "Credit", domain = list(x = c(0, 0.4), y = c(0.4, 1))) %>%
##  add_pie(data = datFinal, labels = ~Account, values = ~Debit,
##          name = "Debit", domain = list(x = c(0.6, 1), y = c(0.4, 1))) %>%
##  layout(title = "Pie Charts with Subplots", showlegend = T,
##         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
##         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

##pcd
