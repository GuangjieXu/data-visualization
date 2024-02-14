# data-visualization
# Final Project Proposal
### Here is the feedback I get:
Need to include the data in the repo. Plot 1: Something looks weird with 2010 boxplot for win - why is the the upper quartile cut off? Y-axis label should be points scored. Plot 2: Need to rename the facet labels like "Three Pointers" etc. There's too many boxplots in this graph - Not sure what we should focus on. Also why does greater variance in assist suggest a gameplay orientation towards assists? Shouldn't lower variance be better since he's more consistent? Plot 3: boxplots for some years look weird, e.g., 2004, 2009, 2011, 2012. Check what's going on. Boxplots are a great tool but when you have so many seasons and variables, it might be better to just focus on the mean/median to get your point across.

### How I will incorporate that feedback and expand the project for the final ?
For the final project, I decide to continue using the topic I selected in assignment 3.

In the final project, I will upload the data I used. You can find the data here:[https://github.com/GuangjieXu/data-visualization/blob/main/lebron_career_final.csv](https://github.com/GuangjieXu/data-visualization/blob/main/lebron_career1.csv)

At the same time, I will consider creating boxplots for only the most important variables such as scores. Since boxplots are not effective in conveying information when the data size is very small (around 15 games per season with similar scores), I will use the ggplot2 library to draw two radar charts for offense and defense instead. Choosing radar charts can effectively display the specific situations of various variables for LeBron James each season. Therefore, I will consider creating interactive radar charts so that readers can choose a season to view the radar chart. Additionally, I will consider modifying the colors of the charts, using maroon to represent victories and brown to represent losses, to avoid using the original red and green colors, as the combination of these two colors is unfriendly to colorblind individuals and not visually appealing. Furthermore, I will try to write out the full names for the y-axis labels and other necessary labels on the charts as much as possible.

These are the modifications and extensions I made based on feedback. For now, I will only choose to create boxplots for scores and radar charts for offensive and defensive variables, totaling three charts. I will strive to make these charts convey more effective information. Additionally, I will try to write out my paper as fully as possible, explaining all relevant content as clearly as possible.

Here I just show what a radar chart might look like. Please forgive my very sloppy drawing skills.
![IMG_0412](https://github.com/GuangjieXu/data-visualization/assets/114622908/402dfe11-b1a2-490c-887f-2dafb52b848b)
