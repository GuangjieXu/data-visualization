---
title: "Untitled"
output: html_document
date: "2024-01-19"
editor_options: 
  markdown: 
    wrap: 72
---
# Part 1: Portfolio 1 Proposal

## Dataset for this assignment and maybe for the rest assignments

Here is the dataset for this assignment and maybe for the rest assignments:

- [Seasons_Stats.csv on GitHub](https://github.com/GuangjieXu/data-visualization/blob/main/Seasons_Stats.csv)
- [Dataset on Kaggle](https://www.kaggle.com/datasets/drgilermo/nba-players-stats?resource=download&select=Seasons_Stats.csv)

LeBron James, an all-time classic player, has been able to give 27.1 points per game as well as 50.1 percent shooting in his 20 years of joining the NBA.

## My question

I'm curious, despite the fact that he has always had very consistent offensive efficiency as the team's top star, does the offensive performance of the team's second and third best players have an impact on his game performance?

## Any challenges you are anticipating

Since this dataset is directly from the already established analysis in Kaggle, there is no need to do any cleaning, but I do need to add a little bit to the data at a later stage.

I didn't need to do any sketching as I had already drawn the more basic but important graphs for my final project in R (as a newbie in R, it took me close to 6 hours to draw these three graphs).

## About my expectation of the final project

This is the first time I hope that from the perspective of a qualified data analyst, I can give some different insights based on my understanding of NBA and the visualization of the data. This is a brand new challenge for me because the content I am going to work on is based on my own point of interest and is original, and there is not the same content analysis on Kaggle. Therefore, it is a new challenge for me. Content analysis might be tough for a newbie like me to explore deeper useful insights as possible.

```{r}
library(dplyr)
library(ggplot2)
library(readr)

# Read the CSV file into a dataframe
lebron_data <- read_csv("~/Desktop/lebron.csv", show_col_types = FALSE)

```

```{r}




# Convert the 'Season' column to a 'Season_Order' column for ordering purposes
lebron_data <- lebron_data %>%
  mutate(Season_Order = as.numeric(substr(Season, 1, 4))) %>%
  arrange(Season_Order) %>%
  mutate(Period = cumsum(Team != lag(Team, default = first(Team))))

# Calculate the average points for each period
average_points_by_period <- lebron_data %>%
  group_by(Period) %>%
  summarize(Average_Points = mean(PTS, na.rm = TRUE),
            Start = min(Season_Order),
            End = max(Season_Order)) %>%
  ungroup()

# Define the colors for each team
team_colors <- c("CLE" = "sandybrown", "MIA" = "red", "LAL" = "purple")

# Now plot with ggplot2, using geom_segment for the team average lines
p<-ggplot(lebron_data, aes(x = Season_Order, y = PTS)) +
  geom_rect(aes(xmin = Season_Order - 0.5, xmax = Season_Order + 0.5, ymin = -Inf, ymax = Inf, fill = Team), alpha = 0.2) +
  geom_line(aes(group = Period)) + # Group by the new Period identifier to connect points within the same period
  geom_point(aes(color = Team)) +
  geom_segment(data = average_points_by_period, aes(x = Start, xend = End, y = Average_Points, yend = Average_Points), 
               linetype = "dashed", color = "black") +
  scale_fill_manual(values = team_colors) +
  scale_color_manual(values = team_colors) +
  theme_minimal() +
  labs(title = "LeBron James Career Points Per Season by Team", y = "Average Points", fill = "Team", color = "Team") +
  theme(legend.position = "bottom", axis.text.x = element_text(angle = 0, vjust = 0.5)) +
  scale_x_continuous(breaks = lebron_data$Season_Order[seq(1, length(lebron_data$Season_Order), by = 2)],
                   labels = lebron_data$Season[seq(1, length(lebron_data$Season), by = 2)])
# Save the plot
ggsave("lebron_points_per_season.png", width = 12, height = 6)
plot(p)

```

<img width="696" alt="image" src="https://github.com/GuangjieXu/data-visualization/assets/114622908/4209a91d-837c-4097-b64a-c223519b33fd">



```{r}



# Convert the 'Season' column to a 'Season_Order' column for ordering purposes
lebron_data <- lebron_data %>%
  mutate(Season_Order = as.numeric(substr(Season, 1, 4))) %>%
  arrange(Season_Order) %>%
  mutate(Period = cumsum(Team != lag(Team, default = first(Team))))

# Calculate the average FG% for each period
average_fg_percentage_by_period <- lebron_data %>%
  group_by(Period) %>%
  summarize(Average_FG_Percentage = mean(`FG%`, na.rm = TRUE),
            Start = min(Season_Order),
            End = max(Season_Order)) %>%
  ungroup()


# For example: team_colors <- c("CLE" = "wine", "MIA" = "red", "LAL" = "gold")
# You need to define team_colors based on the teams present in your dataset

# Now plot with ggplot2, using geom_segment for the team average lines
p <- ggplot(lebron_data, aes(x = Season_Order, y = `FG%`)) +
  geom_rect(aes(xmin = Season_Order - 0.5, xmax = Season_Order + 0.5, ymin = 0, ymax = 100, fill = Team), alpha = 0.2) +
  geom_line(aes(group = Period)) + # Group by the new Period identifier to connect points within the same period
  geom_point(aes(color = Team)) +
  geom_segment(data = average_fg_percentage_by_period, aes(x = Start, xend = End, y = Average_FG_Percentage, yend = Average_FG_Percentage), 
               linetype = "dashed", color = "black") +
  scale_fill_manual(values = team_colors) +
  scale_color_manual(values = team_colors) +
  theme_minimal() +
  labs(title = "LeBron James Career FG% Per Season by Team", y = "Average FG%", fill = "Team", color = "Team") +
  theme(legend.position = "bottom", axis.text.x = element_text(angle = 0, vjust = 0.5)) +
scale_x_continuous(breaks = lebron_data$Season_Order[seq(1, length(lebron_data$Season_Order), by = 2)],
                   labels = lebron_data$Season[seq(1, length(lebron_data$Season), by = 2)])
# Save the plot
ggsave("lebron_fg_percentage_per_season.png", width = 12, height = 6)
plot(p)

```
<img width="696" alt="image" src="https://github.com/GuangjieXu/data-visualization/assets/114622908/dc9c8f43-5c27-4026-a1b2-a787a649f286">

```{r}
library(tidyr)

# Combine FG% and PTS into a single column and create a new column to identify the type of statistic
lebron_long <- lebron_data %>%
  gather(key = "Statistic", value = "Value", `FG%`, PTS)

# Convert the average value data to a long format to be used in the facet plot
average_stats_by_period <- rbind(
  average_fg_percentage_by_period %>% 
    rename(Average_Value = Average_FG_Percentage) %>% 
    mutate(Statistic = "FG%"),
  average_points_by_period %>% 
    rename(Average_Value = Average_Points) %>% 
    mutate(Statistic = "PTS")
)

# Create the facet plot
p <- ggplot(lebron_long, aes(x = Season_Order, y = Value)) +
  geom_rect(aes(xmin = Season_Order - 0.5, xmax = Season_Order + 0.5, ymin = -Inf, ymax = Inf, fill = Team), alpha = 0.2) +
  geom_line(aes(group = Period)) + # Group by the new Period identifier to connect points within the same period
  geom_point(aes(color = Team)) +
  geom_segment(data = average_stats_by_period, aes(x = Start, xend = End, y = Average_Value, yend = Average_Value, group = Period), 
               linetype = "dashed", color = "black") +
  scale_fill_manual(values = team_colors) +
  scale_color_manual(values = team_colors) +
  theme_minimal() +
  labs(title = "LeBron James Career Stats Per Season by Team", y = "Statistic", fill = "Team", color = "Team") +
  theme(legend.position = "bottom", axis.text.x = element_text(angle = 0, vjust = 0.5)) +
  facet_grid(Statistic ~ ., scales = "free_y", space = "free") + # Facet by Statistic, allowing different y-scales
  scale_x_continuous(breaks = lebron_data$Season_Order[seq(1, length(lebron_data$Season_Order), by = 2)],
                     labels = lebron_data$Season[seq(1, length(lebron_data$Season), by = 2)]) # Configure x-axis with custom breaks and labels

# Print the plot for viewing


# Save the plot to a file
ggsave("lebron_combined_stats_per_season.png", plot = p, width = 12, height = 12)
plot(p)
```
<img width="720" alt="image" src="https://github.com/GuangjieXu/data-visualization/assets/114622908/9b839fe0-add2-4e79-9625-31faf1cc9d31">



# Part 2: EDA + Critique

## Consistency and Adaptation

The facet grid clearly depicts LeBron's **consistent offensive efficiency** throughout his career, as seen in the relatively stable FG% over the years. It's evident that despite changes in teams and teammates, LeBron has maintained a high level of performance. This could indicate his ability to adapt his play style to different team dynamics and still remain effective on the court.

## Team Impact

The color coding by team highlights different phases in LeBron's career. There are slight variations in FG% and points scored when he switches teams, which might suggest an adjustment period or changes in team strategies and player roles. For instance, during his time with Miami (colored red), there's a noticeable steadiness in his FG%, which could be attributed to the team's playing style or the support from the team's other top players.

## Insights for Further Exploration

The visual raises questions for further exploration:

- How did the performance of the second and third-best players on each team correlate with changes in LeBron's stats?
- Did LeBron's efficiency improve as a result of having more reliable teammates, or did he have to exert more effort in seasons where the team had less star power?

## What is this story?

The story told here revolves around exploring the consistency of LeBron James' offensive performance throughout his career, specifically looking at how the performance of the team's second and third-best players affects it. By visualizing his field goal percentage and points, we can begin to look for patterns or anomalies that might indicate a correlation between his performance and the support he receives from his teammates.

## Why choose this graphic form?

The faceted grid was chosen for its ability to display multiple statistics side by side while sharing a common axis. This approach allows direct visual comparison of different aspects of performance over the same time period. It avoids clutter and makes it easier to track trends and changes over time. Additionally, using different colors for different teams helps segment career timelines into different stages, potentially linking changes in performance to changes in team dynamics.

## What is the role of interactivity?

I didn't initially consider the aspect of interactivity, but I feel like interactivity can greatly enhance the user experience by allowing for personalized exploration of the data. Therefore, I will work on the following interactivity in the future:

- **Hover tooltips** display precise statistics for each data point, providing more context without overcrowding the chart.
- **Zoom and filtering capabilities** allow viewers to focus on specific seasons, teams, or performance ranges.
- **Clickable legends and team markers** filter the display to only show data relevant to that team, isolating the impact of different team contexts on LeBron's performance.


