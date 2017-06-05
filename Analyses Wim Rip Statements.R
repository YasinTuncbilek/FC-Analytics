# Analyses of Wim Rip (Video-analyst PSV) statements

# Import dataset stats PSV
StatsPSV <- read.csv2("Analysis Wim Rip statements.csv", header = TRUE, sep = ";", dec = ",")

# Read data types
str(StatsPSV)

# Convert integers to character data type
StatsPSV[3:4] <- lapply(StatsPSV[3:4], as.character)

# Check whether converting was ok
str(StatsPSV)

# Convert integers to numeric data type
StatsPSV[5:11] <- lapply(StatsPSV[5:11], as.numeric)

# Check whether converting was ok
str(StatsPSV)

# Season 2014/2015 data
Season1 <- subset(StatsPSV, Season == "2014/2015")

# Season 2015/2016 data
Season2 <- subset(StatsPSV, Season == "2015/2016")

# Season 2016/2017 data
Season3 <- subset(StatsPSV, Season == "2016/2017")

# Check structure Season 1 subset
str(Season1)