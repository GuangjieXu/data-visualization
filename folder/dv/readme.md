Preface: I attempted to use the "deploy app" feature, but encountered errors when opening the link, hence I'm submitting my assignment in text format.

Data Source: https://github.com/GuangjieXu/data-visualization/blob/main/folder/dv/lebron_career1.csv

Executable Code:
https://github.com/GuangjieXu/data-visualization/blob/main/folder/dv/app.R

Regarding my final project, I aim to investigate whether LeBron James' offensive and defensive performance during close-score games in each season of his career is better when he wins compared to when he loses. This inquiry holds significant relevance for LeBron James fans. Throughout James' career, he faced different challenges at various stages. In the early stages, due to the lack of strong teammates, James might have needed to exert himself fully to secure victories. In the mid-stage, with the presence of more talented teammates, he had to consider how to distribute the ball effectively. In the late stage, as his age advanced, he needed to conserve energy to compete for wins, possibly resulting in less noticeable changes in his offensive and defensive performances. Therefore, considering the varying circumstances at different stages, studying LeBron James' performance becomes crucial.
![image](https://github.com/GuangjieXu/data-visualization/assets/114622908/eb7b8421-6435-402e-9902-201373676f94)

For this assignment, I chose to use the Shiny package for data visualization to enhance interaction with the readers. Overall, I selected two radar charts representing offensive and defensive performances, along with a boxplot showing LeBron James' career-season average points.

Regarding the radar charts, among the various packages available for radar charts, I opted for ggradar due to its visually appealing design, circular background, and user-friendly line selection. Importantly, it doesn't require data transposition to fit the radar chart's data format, unlike other packages I experimented with (which took me three hours to resolve the transposition bugs). I provided detailed explanations for each variable to avoid reader confusion. However, due to limited layout space, the full names of the two variables on the right weren't fully displayed. I attempted to adjust parameters to show all variable names, but it resulted in a relatively small radar chart, which was aesthetically unpleasing.

Next is the explanation of the chart: I selected six offensive variables, each with different units and data types (e.g., shooting percentage as a percentage and assists as a numeric value like 11.2). The data is derived from each season's average statistics. I then standardized these variables to a scale of 0-100 (0 representing the career-low for that season's variable, and 100 representing the career-high). From the radar chart, it's evident that in the 2004 season, LeBron James needed to excel in all offensive aspects to win close-score games.

This is the radar chart for the defensive end. Here, I selected four variables representing defense. From the chart, it's evident that in 2004, LeBron James also needed to excel defensively to win games.
![image](https://github.com/GuangjieXu/data-visualization/assets/114622908/5a80399e-23ad-4710-ac18-87b1ee7c275e)

Next is the boxplot. I changed the original color scheme of red and green to the Lakers' colors, purple and gold, giving the boxplot a more basketball-themed feel and avoiding confusion for readers with red-green color blindness. The boxplot, compared to other charts, also allows readers to intuitively see the average score of LeBron James in each season, the distribution of scores in the top 50% and bottom 50%, as well as some outliers (which can be understood as exceptional performances in basketball on a given night).
![image](https://github.com/GuangjieXu/data-visualization/assets/114622908/389175ba-deba-43c5-ade2-f46fd4bd3656)

Overall, I believe this assignment is highly interactive. Readers can freely switch between the three charts and, at the same time, choose different seasons to compare LeBron James' average performance in games won and lost during that season.
