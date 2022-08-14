# Packages
library(dplyr)
library(tidyr)
library(fmsb)
library(scales)
library(knitr)

# Dataset
Dt <- read.csv('Radar Plot.csv')
kable(head(Dt))

# Create a table with averages for each measurement
Dt.Summary <- 
  Dt %>% 
  group_by(Group) %>% 
  summarise(UA.Avg = mean(UA),
            SC.Avg = mean(SC),
            AD.Avg = mean(AD),
            PD.Avg = mean(PD),
            MO.Avg = mean(MO))
kable(Dt.Summary)

# Attach min/max rows into the table 
Dt.Summary.2 <- rbind(c('Max', rep(5, 5)), c('Min', rep(1, 5)), Dt.Summary)
Dt.Summary.2[, 2:6] <- apply(Dt.Summary.2[, 2:6], 2, as.numeric)
kable(Dt.Summary.2)

# the name of each group used in legend ####################################################################
Group <- c('Healthy Control', 'Infected Patients', 'Long-term Symptoms', 'Short-term Symptoms')

# the choice of color for each group #######################################################################
ColorOfGroup <- c("#00AFBB", "#E7B800", "#FC4E07", 'gray')

# the name of each vertex ################################################################################## 
EQ5D5L <- c('Usual\nActivities', 'Self-care', 'Anxiety/\nDepression', 'Pain/\nDiscomfort', 'Mobility')

# Plot ######################################################################################################
# op is used to control the margin of radar chart
op <- par(mar = c(1,2,2,2))
# the main function for figure and choices of parameters
radarchart(
  df = Dt.Summary.2[, 2:6], axistype = 1,
  # Customize the polygon
  pcol = ColorOfGroup, 
  pfcol = alpha(ColorOfGroup, 0.1),  # alpha() is used to control the transparency of color
  plwd = 2, plty = 1,
  # Customize the grid
  cglcol = "black", cglty = 1, cglwd = 0.8,
  # Customize the axis
  axislabcol = "black", caxislabels = 1:5,  calcex = 0.7,
  # Variable labels
  vlcex = 1.25, vlabels = EQ5D5L
)
# Add an horizontal legend
legend("right",        # we put the legend on the right of the radar chart but one can also put
       # it at the bottom of the figure with the command ["bottom", horiz = TRUE]
       legend = Group,     # set up the text for legend
       col = ColorOfGroup, # corresponding colors for groups
       text.col = "black", cex = 1.25, pt.cex = 1.25, bty = "n", pch = 20
)
par(op) # this command is used to perform the setup of margin for radar chart

# arrange positions for multiple radar charts and legends ###################################################
par(mfrow = c(1, 3)) # mfrow = c(1,3) means we want to put plots/legends in 1 row and each plot/legend
# occupies 1 column so totally 3 columns (2 radar charts + 1 legend) 
# op is used to control the margin of radar chart ###########################################################
op <- par(mar = c(1,2,2,1)) # OK to omit this one

# First radar chart ######################################################################################### 
radarchart(
  df = Dt.Summary.2[, 2:6], axistype = 1,
  # Customize the polygon
  pcol = color, pfcol = alpha(color, 0.1), plwd = 2, plty = 1,
  # Customize the grid
  cglcol = "black", cglty = 1, cglwd = 0.8,
  # Customize the axis
  axislabcol = "black", 
  # Variable labels
  vlcex = 1.35, vlabels = EQ5D5L,
  caxislabels = 1:5, calcex = 0.7
)

# Second radar chart ######################################################################################### 
radarchart(
  df = Dt.Summary.2[, 2:6], axistype = 1,
  # Customize the polygon
  pcol = color, pfcol = alpha(color, 0.1), plwd = 2, plty = 1,
  # Customize the grid
  cglcol = "black", cglty = 1, cglwd = 0.8,
  # Customize the axis
  axislabcol = "black", 
  # Variable labels
  vlcex = 1.35, vlabels = EQ5D5L,
  caxislabels = 1:5, calcex = 0.7
)

# Add an horizontal legend ###################################################################################
# control the margin of radar chart and OK to omit it
par(mar = c(0, 0, 0, 0)) 
# Create empty plot 
plot(1, type = "n", axes = FALSE, xlab = "", ylab = "") 
# Attach the legend to the empty plot
legend('left',  # this 'left' means we want to put the legend on the left side of the empty plot
       # and this is close to the 2 radar charts
       legend = c('Healthy Control', 'Infected Patients', 'Long-term Symptoms', 'Short-term Symptoms'),
       col = c("#00AFBB", "#E7B800", "#FC4E07", 'gray'),
       pch = 20, cex = 1.35, pt.cex = 1.35, bty = "n")

par(op)

