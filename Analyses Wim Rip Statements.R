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

# Create table with sum of chances, crosses, set piece goals, All shots (excluding blocks) and goals per season
Table1 <- aggregate(cbind(StatsPSV$Chances.PSV, StatsPSV$Crosses.PSV, StatsPSV$Set.piece.goals.PSV, StatsPSV$Shots.PSV..excl..blocks., StatsPSV$Goals.PSV), list(StatsPSV$Season), FUN = sum)

# Change column names of Table 1
colnames(Table1) <- c("Season", "Chances", "Crosses", "Set piece goals", "All shots (excluding blocks)", "Goals")

# Check dataframe of Table 1
data.frame(Table1)

# Create new variable Conversion 
Table1["Conversion"] <- NA

# Add variable Conversion as a column to Table 1
Table1$Conversion <- (Table1$Goals / Table1$`All shots (excluding blocks)`) * 100

# Round values in Table 1 to two decimals
Table1$Conversion <- round(Table1$Conversion, 2)

# Check dataframe of Table 1
data.frame(Table1)

# Create table with mean of possession, chances, crosses and set piece goals per season
Table2 <- aggregate(cbind(StatsPSV$Possession.PSV...., StatsPSV$Chances.PSV, StatsPSV$Crosses.PSV, StatsPSV$Set.piece.goals.PSV), list(StatsPSV$Season), FUN = mean)

# Change column names of Table 2
colnames(Table2) <- c("Season", "Possession", "Chances", "Crosses", "Set piece goals")

# Round values in Table 2 to two decimals, exclude first column
Table2[,-1] <- round(Table2[,-1], 2)

# Check dataframe of Table 2
data.frame(Table2)

# Create overall table with all relevant information
Table3 <- cbind(Table1, Table2$Possession)

# Change column name into Possession
colnames(Table3)[8] <- "Possession"

# Change order of columns (Possession more to the front)
Table3 <- Table3[ ,c(1, 8, 2:7)]

# Check dataframe of Table 3
data.frame(Table3)

# One-way ANOVA on possession
analysis1 <- lm(StatsPSV$Possession.PSV....~as.factor(StatsPSV$Season), data = StatsPSV)
anova(analysis1)
plot(analysis1, which = 1)
plot(analysis1, which = 2)
sresids1 <- rstandard(analysis1)
hist(sresids1)
TukeyHSD(aov(analysis1))
