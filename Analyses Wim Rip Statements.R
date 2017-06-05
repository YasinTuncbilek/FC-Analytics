# Analyses of Wim Rip (Video-analyst PSV) statements

# Import dataset stats PSV
StatsPSV <- read.csv2("Analysis Wim Rip statements.csv", header = TRUE, sep = ";", dec = ",")

# Read data types
str(StatsPSV)

# Season 2014/2015 data
Season1 <- subset(StatsPSV, Season == "2014/2015")

# Season 2015/2016 data
Season2 <- subset(StatsPSV, Season == "2015/2016")

# Season 2016/2017 data
Season3 <- subset(StatsPSV, Season == "2016/2017")