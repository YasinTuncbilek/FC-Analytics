# Load Selenium package
library(RSelenium)
require(RSelenium)

# Connect to server
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4445L
                      , browserName = "firefox")

# Open connection
remDr$open()

# Get connection status
remDr$getStatus()

# Set implicit wait time
remDr$setImplicitWaitTimeout(3000)

# Navigate to data request page
remDr$navigate("http://eredivisie.squawka.com/willem-ii-vs-psv/10-08-2014/dutch-eredivisie/matches")

# Get script
squawkData <- remDr$executeScript("return new XMLSerializer().serializeToString(squawkaDp.xml);", list())

# Load selectr package
library(selectr)
require(selectr)

# Load XML package
library(XML)
require(XML)

# Parsing: crosses
crosses <- querySelectorAll(xmlParse(squawkData[[1]]), "crosses time_slice")

# Print crosses [[1]]
crosses[[1]]

# Print example
crosses

# Select xml attributes and values
data <- xpathSApply(crosses, "//event", xmlAttrs)

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

# Turn off global debugging
debuggingState(on = FALSE)


