##################################################
## Title: Data Preparation
## Description:
## Input(s):
## Output(s):
##################################################

# read in the 5 data sets w/ relative file paths
column_classes <- c("character", "character", "integer", "integer", "integer", "integer", "character", 
                    "factor", "factor", "integer", "character", "integer", "integer")
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE, colClasses = column_classes)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE, colClasses = column_classes)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE, colClasses = column_classes)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE, colClasses = column_classes)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE, colClasses = column_classes)

# add column 'name' to each imported df w/ name of corr player
iguodala["name"] <- "Andre Iguodala"
green["name"] <- "Draymond Green"
durant["name"] <- "Kevin Durant"
thompson["name"] <- "Klay Thompson"
curry["name"] <- "Stephen Curry"

# change original values of shot_made_flag to more descriptive values
# "n" -> "shot_no"
# "y" -> "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"

iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"

# add column 'minute' w/ minute number where a shot occurred
iguodala["minute"] = (iguodala["period"]) * 12 - iguodala["minutes_remaining"]
green["minute"] = (green["period"]) * 12 - green["minutes_remaining"]
durant["minute"] = (durant["period"]) * 12 - durant["minutes_remaining"]
thompson["minute"] = (thompson["period"]) * 12 - thompson["minutes_remaining"]
curry["minute"] = (curry["period"]) * 12 - curry["minutes_remaining"]

# use sink to send the summary output into individual text files e.g. output/andre-iguodala.txt
sink("../output/andre-iguodala.txt", type = "output")
summary(iguodala)
sink()

sink("../output/draymond-green.txt", type = "output")
summary(green)
sink()

sink("../output/kevin-durant.txt", type = "output")
summary(durant)
sink()

sink("../output/klay-thompson.txt", type = "output")
summary(thompson)
sink()

sink("../output/stephen-curry.txt", type = "output")
summary(curry)
sink()

# use rbind to stack the tables into 1 df
combined_shots <- do.call("rbind", list(iguodala, green, durant, thompson, curry))

# export the assembled table as data/shots-data.csv
write.csv(combined_shots, "../data/shots-data.csv")

# use sink to send the summary output of the assembled table to output/shots-data-summary
sink("../output/shots-data-summary.txt", type = "output")
summary(combined_shots)
sink()