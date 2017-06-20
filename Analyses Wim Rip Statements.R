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

# Create table with sum of chances, crosses and set piece goals per season
Table1 <- aggregate(cbind(StatsPSV$Chances.PSV, StatsPSV$Crosses.PSV, StatsPSV$Set.piece.goals.PSV), list(StatsPSV$Season), FUN = sum)

# Change column names of Table 1
colnames(Table1) <- c("Season", "Chances", "Crosses", "Set piece goals")

# Check dataframe of Table 1
data.frame(Table1)

# Create table with mean of possession, chances, crosses, set piece goals and conversion per season
Table2 <- aggregate(cbind(StatsPSV$Possession.PSV...., StatsPSV$Chances.PSV, StatsPSV$Crosses.PSV, StatsPSV$Set.piece.goals.PSV, StatsPSV$Conversion.PSV..w.shots.), list(StatsPSV$Season), FUN = mean)

# Change column names of Table 2
colnames(Table2) <- c("Season", "Possession", "Chances", "Crosses", "Set piece goals", "Conversion")

# Check dataframe of Tale 2
data.frame(Table2)

# Copy table 1 