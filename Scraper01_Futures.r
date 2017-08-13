#install.packages("magrittr")
#install.packages("XML")
#install.packages("RSelenium")
library(RSelenium)
library(XML)
library(magrittr)
rm(list = ls())
setwd("C:/Progs/")
# Start Selenium Server --------------------------------------------------------
selServ <- startServer() 
remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4444 , browserName = "chrome" , extraCapabilities = list(marionette = TRUE))
remDr$open()


# Simulate browser session and fill out form -----------------------------------

df<-read.csv("TradingDays2.txt",header=T,sep='\t',colClasses = "character",fileEncoding="utf-16")
tradingdays<-df[(df[,2]==1),]

for (i in 1400:4191) {
  print(as.character(tradingdays[i,1]))
  Sys.sleep(runif(1,1,5))
  remDr$navigate('http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp')
  kkk<-remDr$findElement(using="css","[name=dData1]")
  lll<-remDr$findElement(using="css","[class = 'button expand']")
  kkk$clearElement()
  
  kkk$sendKeysToElement(list(as.character(tradingdays[i,1])))
  lll$clickElement()
  
  table <- remDr$getPageSource()[[1]] %>% 
    htmlParse %>% 
    readHTMLTable %>% 
    extract2(1)
  assign(paste("SelPrices", i, sep = '_'), table)
  
  
}




remDr$quit()
remDr$closeServer()

head(table)