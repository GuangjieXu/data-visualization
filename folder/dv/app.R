library(dplyr)
library(tidyr)
library(ggplot2)
library(shiny)

ui <- fluidPage(theme = shinytheme("cerulean"),
                # Define UI for application that draws a histogram
                h1("LeBron James' offensive and defensive performance in games with close scores"),
                h2("Analyze LeBron James' performance each season"),
                h4("Use win and loss to group and analyze"),
                navlistPanel(
                  "Analysis options",
                  tabPanel("LeBron James' offensive performance",
                           mainPanel(textInput("offensive_season",
                                               "Lookup season(2004-2017):",
                                               value = "2004"),
                                     plotOutput("radarPlot1"),
                                     width = 11)),
                  tabPanel("LeBron James' defensive performance",
                           mainPanel(textInput("defensive_season",
                                               "Lookup season(2004-2017):",
                                               value = "2004"),
                                     plotOutput("radarPlot2"),
                                     width = 11)),
                  tabPanel("LeBron James' points per game by season",
                           mainPanel(plotOutput("boxplotLeast"),
                                     width = 11)
                  )) )


makeRadarPlot_offensive <- function(inputSeason) {
  # Read the data
  data <- read.csv("~/Documents/dv/lebron_radar.csv")
  
  # Filter data for the specified season and select required columns
  data_2010 <- subset(data, select = c("wl", "FieldGoalPercentage", "ThreePointPercentage", "FreeThrowAttemptPercentage", "Assists", "Points", "Turnovers"), season == inputSeason)
  
  # Remove the "season" column from data_2010
  data_2010 <- data_2010[, !(names(data_2010) == "season")]
  
  # Plot the radar chart using ggradar
  ggradar(
    data_2010, 
    values.radar = c("0", "50", "100"),  # Set scale values from 0 to 100 with steps of 20
    grid.min = 0, grid.mid = 50, grid.max = 100,  # Set grid values for minimum, middle, and maximum
    # Polygons
    group.line.width = 1, 
    group.point.size = 3,
    group.colours = c("#00AFBB", "#E7B800"),
    # Background and grid lines
    background.circle.colour = "white",
    gridline.mid.colour = "grey",
    legend.position = "bottom"
  )
}

makeRadarPlot_defensive <- function(inputSeason) {
  # Read the data
  data <- read.csv("~/Documents/dv/lebron_radar.csv")
  
  # Filter data for the specified season and select required columns
  data_2010 <- subset(data, season == inputSeason, select = c("wl", "OffensiveRebounds", "DefensiveRebounds", "Steals", "Blocks"))
  
  # Remove the "season" column from data_2010
  data_2010 <- data_2010[, !(names(data_2010) == "season")]
  
  # Plot the radar chart using ggradar
  ggradar(
    data_2010, 
    values.radar = c("0", "50", "100"),  # Set scale values from 0 to 100 with steps of 20
    grid.min = 0, grid.mid = 50, grid.max = 100,  # Set grid values for minimum, middle, and maximum
    # Polygons
    group.line.width = 1, 
    group.point.size = 3,
    group.colours = c("#00AFBB", "#E7B800"),
    # Background and grid lines
    background.circle.colour = "white",
    gridline.mid.colour = "grey",
    legend.position = "bottom"
  )
}

server <- function(input, output) {
  output$radarPlot1 <- renderPlot({
    makeRadarPlot_offensive(input$offensive_season)
  })
  
  output$radarPlot2 <- renderPlot({
    makeRadarPlot_defensive(input$defensive_season)
  })
  
  output$boxplotLeast <- renderPlot({
    lebron_data <- read_csv('~/Documents/dv/lebron_career1.csv', show_col_types = FALSE)
    
    # Convert date format and create a season column
    lebron_data$date <- as.Date(lebron_data$date, format="%Y/%m/%d")
    lebron_data$season <- as.numeric(format(lebron_data$date, "%Y"))
    
    # Convert data from wide to long format for plotting
    lebron_long <- lebron_data %>%
      pivot_longer(cols = c(pts), names_to = "statistic", values_to = "value")
    
    # Create a box plot using ggplot2, with season on the x-axis and win/loss as grouping
    ggplot(lebron_long, aes(x = factor(season), y = value, fill = wl)) +
      geom_boxplot() +
      labs(
        title = "LeBron's Points by Season and Win/Loss (2004-2017)",
        x = "Season",
        y = "Value",
        fill = "Result"
      ) +
      theme_minimal() +
      theme(
        strip.background = element_rect(fill = "lightblue"),
        strip.text.x = element_text(size = 12, color = "black", face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1), # Rotate x-axis labels to avoid overlap
        legend.position = "none" # Remove legend
      ) +
      scale_fill_manual(values = c("purple", "gold")) # Set boxplot fill colors to purple and gold
  })
  
  
  
}

# Run the application 
shinyApp(ui=ui, server=server)

