# Load the gaze data
sankey <- read_csv("data/Sankey/gaze_data.csv", col_names = FALSE)

col_names <- c("Left Eye X", "Left Eye Y", "Right Eye X", "Right Eye Y")

colnames(sankey) <- col_names

# Removing NaN from the data
sankey <- sankey[complete.cases(sankey), ]

# Calculate the average gaze point between left and right eyes
sankey$Average_X <- (sankey$`Left Eye X` + sankey$`Right Eye X`) / 2
sankey$Average_Y <- (sankey$`Left Eye Y` + sankey$`Right Eye Y`) / 2

# Create the heatmap for the average gaze points with smaller circles (h = 0.02) and without labels, grid, and legend
heatmap_sk <- ggplot(sankey, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  theme_void() +
  theme(legend.position = "none")

# Print the heatmap
print(heatmap_sk)

