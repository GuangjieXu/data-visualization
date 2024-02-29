library(fmsb)
library("ggradar")
library(ggplot2)


# 读取数据集
data <- read.csv("~/Desktop/lebron_radar.csv")
# 筛选出2004年的数据，并且只选取需要的列
data_2004 <- subset(data, select = c("wl", "FieldGoalPercentage", "ThreePointPercentage", "FreeThrowAttemptPercentage", "Assists", "Points", "Turnovers"), season == 2010)
# 删除 data_2004 中的 season 列
data_2004 <- data_2004[, !(names(data_2004) == "season")]
p<-ggradar(
  data_2004, 
  values.radar = c("0", "50","100"),  # 设置刻度值为0到100，每隔20一个刻度
  grid.min = 0, grid.mid = 50, grid.max = 100,  # 设置网格的最小值、中间值和最大值
  # Polygons
  group.line.width = 1, 
  group.point.size = 3,
  group.colours = c("#00AFBB", "#E7B800"),
  # Background and grid lines
  background.circle.colour = "white",
  gridline.mid.colour = "grey",
  legend.position = "bottom")

P



# 读取数据集
data <- read.csv("~/Desktop/lebron_radar.csv")

# 筛选出2010年的数据，并且只选取需要的列
data_2010 <- subset(data, season == 2010, select = c("wl", "OffensiveRebounds", "DefensiveRebounds", "Steals", "Blocks"))

# 删除 data_2010 中的 season 列
data_2010 <- data_2010[, !(names(data_2010) == "season")]

# 重命名列
colnames(data_2010) <- c("wl", "Offensive Rebounds", "Defensive Rebounds", "Steals", "Blocks")

# 绘制雷达图
p <- ggradar(
  data_2010, 
  values.radar = c("0", "50", "100"),  # 设置刻度值为0到100，每隔20一个刻度
  grid.min = 0, grid.mid = 50, grid.max = 100,  # 设置网格的最小值、中间值和最大值
  # Polygons
  group.line.width = 1, 
  group.point.size = 3,
  group.colours = c("#00AFBB", "#E7B800"),
  # Background and grid lines
  background.circle.colour = "white",
  gridline.mid.colour = "grey",
  legend.position = "bottom"
)





library(rsconnect)
rsconnect::setAccountInfo(name='gj1012449308',
                          token='F6D7BE47E519E244AB8D321E447691DA',
                          secret='MTQp0HTshjq66nQ6TEqYVL2HFm0gZMwUq5/Ga0Gp')
library(rsconnect)
rsconnect::deployApp(appDir = "~/Documents/dv/", appName = "appfinal")





