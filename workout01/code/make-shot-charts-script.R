##################################################
## Title: Shot Charts
## Description:
## Input(s):
## Output(s):
##################################################

# import necessary libraries
library(jpeg)
library(grid)
library(ggplot2)
library(dplyr)

# import data from shots_data
column_classes = c("character", "character", "character", "integer", "integer", "integer", "integer", "character", "character",
                   "character", "integer", "character", "integer", "integer", "character", "integer")
shots_data <- read.csv("../data/shots-data.csv", stringsAsFactors = FALSE, colClasses = column_classes)
andre <- filter(shots_data, name == "Andre Iguodala")
draymond <- filter(shots_data, name == "Draymond Green")
kevin <- filter(shots_data, name == "Kevin Durant")
klay <- filter(shots_data, name == "Klay Thompson")
stephen <- filter(shots_data, name == "Stephen Curry")

# court image (to be used as background of plot)
court_file <- "../images/nba-court.jpg"

# create raster object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc")
)

# shot charts of each player
andre_shot_chart <- ggplot(data = andre) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + ylim(-50, 420) + 
  ggtitle("Shot Chart: Andre Iguodala (2016 season)") + 
  theme_minimal()
ggsave(filename = "../images/andre-iguodala-shot-chart.pdf", plot = andre_shot_chart, 
       width = 6.5, height = 5, units = "in")

draymond_shot_chart <- ggplot(data = draymond) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + ylim(-50, 420) + 
  ggtitle("Shot Chart: Draymond Green (2016 season)") + 
  theme_minimal()
ggsave(filename = "../images/draymond-green-shot-chart.pdf", plot = draymond_shot_chart, 
       width = 6.5, height = 5, units = "in")

kevin_shot_chart <- ggplot(data = kevin) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + ylim(-50, 420) + 
  ggtitle("Shot Chart: Kevin Durant (2016 season)") + 
  theme_minimal()
ggsave(filename = "../images/kevin-durant-shot-chart.pdf", plot = kevin_shot_chart,
       width = 6.5, height = 5, units = "in")

klay_shot_chart <- ggplot(data = klay) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + ylim(-50, 420) + 
  ggtitle("Shot Chart: Klay Thompson (2016 season)") + 
  theme_minimal()
ggsave(filename = "../images/klay-thompson-shot-chart.pdf", plot = klay_shot_chart,
       width = 6.5, height = 5, units = "in")

stephen_shot_chart <- ggplot(data = stephen) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + ylim(-50, 420) + 
  ggtitle("Shot Chart: Stephen Curry (2016 season)") + 
  theme_minimal()
ggsave(filename = "../images/stephen-curry-shot-chart.pdf", plot = stephen_shot_chart,
       width = 6.5, height = 5, units = "in")

# facetted shot chart
gsw_shot_charts <- ggplot(data = shots_data) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + ylim(-50, 420) + ggtitle("Shot Charts: GSW (2016 season)") +
  theme_minimal() + facet_wrap(~ name)
ggsave(filename = "../images/gsw-shot-charts.pdf", plot = gsw_shot_charts,
       width = 8, height = 7, units = "in")
ggsave(filename = "../images/gsw-shot-charts.png", plot = gsw_shot_charts,
       width = 8, height = 7)