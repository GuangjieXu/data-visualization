library(dplyr)
library(tidyr)
library(ggplot2)
library(shiny)
library(shinythemes)
library(ggradar)
library(readr)

ui <- fluidPage(theme = shinytheme("cerulean"),
                # Define UI for application that draws a histogram
                h1("LeBron James' offensive and defensive performance in games with close scores"),
                h2("Analyze LeBron James' performance each season"),
                h4("Use win and loss to group and analyze"),
                navlistPanel(
                  "Analysis options",
                  tabPanel("LeBron James' performance",
                           mainPanel(
                             fluidRow(
                               column(6,
                                      radioButtons("performance_type",
                                                   "Select performance type:",
                                                   c("Offensive" = "offensive", "Defensive" = "defensive"),
                                                   selected = "offensive")
                               ),
                               column(6,
                                      sliderInput("season",
                                                  "Select season (2004-2017):",
                                                  min = 2004, max = 2017, value = 2004)
                               )
                             ),
                             plotOutput("radarPlot"),
                             width = 11
                           )
                  )
                  ,
                  tabPanel("LeBron James' Performance",
                           fluidRow(
                             column(4,
                                    selectInput("variable",
                                                "Select a variable :",
                                                choices = c("Field Goal%" = "Field Goal%",
                                                            "3Points%" = "3Points%",
                                                            "Free Throw%" = "Free Throw%",
                                                            "Offensive Rebound" = "Offensive Rebound",
                                                            "Deffensive Rebound" = "Deffensive Rebound",
                                                            "Assist" = "Assist",
                                                            "Blocks" = "Blocks",
                                                            "Steal" = "Steal",
                                                            "Turnover" = "Turnover",
                                                            "Points" = "Points"),
                                                selected = "Field Goal%")
                             ),
                             column(8,
                                    plotOutput("performancePlot")
                             )
                           )
                  ),
                  tabPanel("LeBron James' points per game by season",
                           mainPanel(plotOutput("boxplotLeast"),
                                     width = 11)
                  )) )


makeRadarPlot_offensive <- function(inputSeason) {
  # Read the data
  data <- read.csv("./lebron_radar.csv")
  
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

generate_lebron_plot <- function(input_variable) {
  # Load data
  lebron_data <- read_csv("lebron1.csv", show_col_types = FALSE)
  
  # Check if the input variable exists in the dataset
  if (!(input_variable %in% names(lebron_data))) {
    stop("Input variable does not exist in the dataset")
  }
  
  # Convert 'Season' to a numeric 'Season_Order' for ordering
  lebron_data <- lebron_data %>%
    mutate(Season_Order = as.numeric(substr(Season, 1, 4))) %>%
    arrange(Season_Order) %>%
    mutate(Period = cumsum(Team != lag(Team, default = first(Team))))
  
  # Calculate the mean of the input variable for each period
  average_points_by_period <- lebron_data %>%
    group_by(Period) %>%
    summarize(Average_Points = mean(!!sym(input_variable), na.rm = TRUE),
              Start = min(Season_Order),
              End = max(Season_Order)) %>%
    ungroup()
  
  # Define team colors
  team_colors <- c("CLE" = "sandybrown", "MIA" = "red", "LAL" = "purple")
  
  # Determine y-axis limits based on the range of the input variable
  y_limits <- range(lebron_data[[input_variable]], na.rm = TRUE)
  
  # Create the plot object
  p <- ggplot(lebron_data, aes(x = Season_Order, y = !!sym(input_variable))) +
    geom_rect(aes(xmin = !!sym("Season_Order") - 0.5, xmax = !!sym("Season_Order") + 0.5, ymin = -Inf, ymax = Inf, fill = Team), alpha = 0.2) +
    geom_line(aes(group = Period)) +
    geom_point(aes(color = Team)) +
    geom_segment(data = average_points_by_period, aes(x = Start, xend = End, y = Average_Points, yend = Average_Points),
                 linetype = "dashed", color = "black") +
    scale_fill_manual(values = team_colors) +
    scale_color_manual(values = team_colors) +
    theme_minimal() +
    labs(title = paste("LeBron James' Performance:", input_variable),
         y = input_variable,
         fill = "Team", color = "Team") +
    theme(legend.position = "bottom", axis.text.x = element_text(angle = 0, vjust = 0.5)) +
    scale_x_continuous(breaks = lebron_data$Season_Order[seq(1, length(lebron_data$Season_Order), by = 2)],
                       labels = lebron_data$Season[seq(1, length(lebron_data$Season), by = 2)]) +
    scale_y_continuous(limits = y_limits) # Dynamic y-axis limits
  
  # Return the plot object
  return(p)
}





makeRadarPlot_defensive <- function(inputSeason) {
  # Read the data
  data <- read.csv("./lebron_radar.csv")
  
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
  output$radarPlot <- renderPlot({
    if (input$performance_type == "offensive") {
      makeRadarPlot_offensive(input$season)
    } else {
      makeRadarPlot_defensive(input$season)
    }
  })
  output$performancePlot <- renderPlot({

    generated_plot <- generate_lebron_plot(input$variable)

    print(generated_plot)
  })
  output$boxplotLeast <- renderPlot({
    lebron_data <- read_csv('./lebron_career1.csv', show_col_types = FALSE)
    
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
        y = "Average Points Per season",
        fill = "Result"
      ) +
      theme_minimal() +
      theme(
        strip.background = element_rect(fill = "lightblue"),
        strip.text.x = element_text(size = 12, color = "black", face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1), # Rotate x-axis labels to avoid overlap
        legend.position = "bottom" # Remove legend
      ) +
      scale_fill_manual(values = c("purple", "gold")) # Set boxplot fill colors to purple and gold
  })
}


# Run the application 
shinyApp(ui=ui, server=server)

