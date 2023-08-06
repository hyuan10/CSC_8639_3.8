# Load the gaze data
waterfall <- read_csv("data/Waterfall/gaze_data.csv", col_names = FALSE)

col_names <- c("Left Eye X", "Left Eye Y", "Right Eye X", "Right Eye Y")

colnames(waterfall) <- col_names

# Removing NaN from the data
waterfall <- waterfall[complete.cases(waterfall), ]

# Calculate the average gaze point between left and right eyes
waterfall$Average_X <- (waterfall$`Left Eye X` + waterfall$`Right Eye X`) / 2
waterfall$Average_Y <- (waterfall$`Left Eye Y` + waterfall$`Right Eye Y`) / 2

# Create the heatmap for the average gaze points with smaller circles (h = 0.02) and without labels, grid, and legend
heatmap_wf <- ggplot(waterfall, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.03) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  theme_minimal() +
  theme(legend.position = "none") +  
  scale_x_continuous(limits = c(0, 1)) +
  scale_y_continuous(limits = c(0, 1))
  

# Print the heatmap
print(heatmap_wf)


heatmap_wf <- ggplot(waterfall, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.03) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_x_continuous(limits = c(0, 1)) +
  scale_y_continuous(limits = c(0, 1))

# Print the heatmap with axis data gridlines and numbers on the edges
print(heatmap_wf)
