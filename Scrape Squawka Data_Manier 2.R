# Load XML package
library("XML",lib.loc="/home/jbrunek/test/libs")
require("XML")

# Parsing
dp <- xmlParse("http://s3-irl-eredivisie.squawka.com/dp/ingame/7926")
top = xmlRoot(dp)

# Filter out crosses
crosses <- top[['data_panel']][['filters']][['crosses']]

# Filter out all_passes
all_passes <- top[['data_panel']][['filters']][['all_passes']]

# Filter out goals_attempts
goals_attempts <- top[['data_panel']][['filters']][['goals_attempts']]

# Select crosses
data_crosses <- xpathSApply(top, "//crosses//event", xmlAttrs)

# Select all_passes
data_all_passes <- xpathSApply(top, "//all_passes//event", xmlAttrs)

# Select goals_attempts
data_goals_attempts <- xpathSApply(top, "//goals_attempts//event", xmlAttrs)

data1 <- xpathApply(goals_attempts, "//goals_attempts//event", xmlAttrs)
data
data1
crosses
all_passes
goals_attempts