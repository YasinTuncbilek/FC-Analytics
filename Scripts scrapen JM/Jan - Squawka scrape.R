#libraries inladen
library('RSelenium')
library(curl)
library(XML)
library(selectr)

#Deze functie start een webbrowser (server) op een gespecificeerde uitgaande poort. 
#Om geen problemen te krijgen met de firewall van de laptop zet de poort op as.integer(4444)
#Bekijk hiervoor de help functie van rsDriver. Sluit het geopende browserwindow af. 
rsDriver(port = as.integer(4444))

# Nu kan er een object worden gemaakt met daarin de bestuursgegevens van een gespecificeerde browser.
# Hiervoor gebruiken we de functie remoteDriver(), waarvan de uitkomst toe moet worden gewezen aan een object.
# Om chrome te gebruiken als de browser, zet als argument: browserName = "chrome"
remDr <- remoteDriver(browserName = "chrome") 

#nu kan met dit object een browser window worden bestuurd. Eerst moet deze worden geopend. Dit gaat als volgt:
#object$open(). Open nu de browser
remDr$open()

#Navigeer naar de benodigde informatie op het web. 
site <- "http://eredivisie.squawka.com/dutch-eredivisie/09-09-2017/willem-ii-vs-den-haag/matches"
remDr$navigate(site)

#remDr$navigate ("http://eredivisie.squawka.com/dutch-eredivisie/25-08-2017/nac-breda-vs-sparta-rotterdam/matches")

#Ontvangen van de XML data als een list. Enkel nog karakters nu. 
squawkData <- remDr$executeScript("return new XMLSerializer().serializeToString(squawkaDp.xml);")

#Dit converteren naar een XML
squawkxml <- xmlTreeParse(squawkData[[1]], useInternalNodes = T)
write(saveXML(squawkxml), 'squawka.xml')

a = querySelectorAll(xmlParse(squawkData[[1]]), " time_slice")
b = querySelectorAll(xmlParse(squawkData[[1]]), "crosses time_slice")
example <- querySelectorAll(xmlParse(squawkData[[1]]), "crosses time_slice")

out <- lapply(example, function(x){
  # handle each event
  if(length(x['event']) > 0){
    res <- lapply(x['event'], function(y){
      matchAttrs <- as.list(xmlAttrs(y))
      matchAttrs$start <- xmlValue(y['start']$start)
      matchAttrs$end <- xmlValue(y['end']$end)
      matchAttrs
    })
    return(do.call(rbind.data.frame, res))
  }
}
)

xmlValue(querySelectorAll(xmlParse(squawkData[[1]]), " type")[[1]])


eventchar <- as(events[[1]], "character")
substr(eventchar, gregexpr("event type", eventchar, )
)

?querySelectorAll()

events <-
  querySelectorAll(squawkxml, " time_slice")

xpathApply(events[[1]], " time_slice", xmlValue)



xpathApply(squawkxml, " cross", xmlValue)


as.character(events[[1]])

events <-
  querySelectorAll(squawkxml, " event")

events[[1]]

class(events[[1]])

res <- do.call(rbind, lapply(events, eventHandler))






#en uitfilteren van alle events apart. 
  #Eerst inladen van de events uit het textbestand EventType.txt
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  event.names <- read.csv("EventType.txt", header = T)
  event.names <- as.character(event.names$descr)

  
  #Daarna event.df dataframe maken. 
  event.df <- as.data.frame(setNames(replicate(length(event.names),, simplify = F), event.names))
  
allEvents <- function(event_types, squawkxml){
  for (event_type in event_types) {
      if (event_type == event_types[1]) {
        events <-
          querySelectorAll(squawkxml, paste0(event_type, " time_slice"))
        event.df <- do.call(rbind, lapply(events, eventHandler))
        event.df$event_type <- event_type
      }else{
        events <-
          querySelectorAll(squawkxml, paste0(event_type, " time_slice"))
        res <- do.call(rbind, lapply(events, eventHandler))
        if(!is.null(res)){
          res$event_type <- event_type
          event.df <- rbind(event.df, res)
        }
      }
    }
  return(event.df)
}


#functie uitvoeren om elke teamevent naar een teamnaam te converteren
event.df$team <- as.numeric(as.character(event.df$team))
for(teamcode in unique(event.df$team)){
  syntax <- paste0("team#", teamcode, " long_name")
  naam <- xmlValue(querySelectorAll(xmlParse(squawkData[[1]]), syntax)[[1]])
  event.df$team[event.df$team == teamcode] <- naam
}

#functie uitvoeren om elke player id naar een spelersnaam te converteren
event.df$player_id <- as.numeric(as.character(event.df$player_id))
for(player_id in unique(event.df$player_id)){
  syntax <- paste0("players #", player_id, " name")
  naam <- xmlValue(querySelectorAll(xmlParse(squawkData[[1]]), syntax)[[1]])
  event.df$player_id[event.df$player_id == player_id] <- naam
1}

####EXTRA#####
#splitsen van de coordinaten
DF <- data.frame(do.call(rbind, strsplit(as.character(event.df$start), ",", fixed=TRUE)))



