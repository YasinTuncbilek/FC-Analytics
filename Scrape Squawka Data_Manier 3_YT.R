# Libraries inladen.
library('RSelenium')
library(curl)
library(XML)
library(selectr)

# Deze functie start een webbrowser (server) op een gespecificeerde uitgaande poort. 
# Om geen problemen te krijgen met de firewall van de laptop zet de poort op as.integer(4444).
# Bekijk hiervoor de help functie van rsDriver. Sluit het geopende browserwindow af. 
rsDriver(port = as.integer(4444))

# Nu kan er een object worden gemaakt met daarin de bestuursgegevens van een gespecificeerde browser.
# Hiervoor gebruiken we de functie remoteDriver(), waarvan de uitkomst toe moet worden gewezen aan een object.
# Om chrome te gebruiken als de browser, zet als argument: browserName = "chrome"
remDr <- remoteDriver(browserName = "chrome")
#nu kan met dit object een browser window worden bestuurd. Eerst moet deze worden geopend. Dit gaat als volgt:
#object$open(). Open nu de browser
remDr$open()
#Navigeer naar de benodigde informatie op het web. 
remDr$navigate ("http://eredivisie.squawka.com/dutch-eredivisie/25-08-2017/nac-breda-vs-sparta-rotterdam/matches")
#Ontvangen van de XML data als een list. Enkel nog karakters nu. 
squawkData <- remDr$executeScript("return new XMLSerializer().serializeToString(squawkaDp.xml);", args = list("dummy"))
#Dit converteren naar een XML --> xmlTreeparse ipv xml parse
#zorgt voor convertering naar text in plaats van pointers zoals bij xmlParse
squawkxml <- xmlParse(squawkData[[1]])
#en uitfilteren van de "event" tag. 
events <- querySelectorAll(squawkxml,  "crosses time_slice")
events
#converteren naar dataframe
out <- do.call(rbind, lapply(events, newfunc))
###Functies
attrFunc <- function(y){
  #Stukje extra, zorgt voor uitfilteren van alle stukjes. 
  names = c("player_id","mins","secs","minsec","team","type")
  matchAttrs <- as.list(xmlAttrs(y)[names(xmlAttrs(y)) %in% names])
  matchAttrs$start <- xmlValue(y["start"]$start)
  matchAttrs$end <- xmlValue(y["end"]$end)
  print(matchAttrs)
}
newfunc <- function(x){
  # handle each event
  if(length(x['event']) > 0){
    res <- lapply(x["event"], attrFunc)
    return(do.call(rbind.data.frame, res))
  }
}

out