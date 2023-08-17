# Load the gaze data
waterfall <- read_csv("data/Waterfall/gaze_data.csv", col_names = FALSE)

# Set column names
colnames(waterfall) <- col_names

# Remove NaN rows from the data
waterfall <- waterfall[complete.cases(waterfall), ]

# Calculate the average gaze point between left and right eyes
waterfall$Average_X <- (waterfall$`Left Eye X` + waterfall$`Right Eye X`) / 2
waterfall$Average_Y <- ((waterfall$`Left Eye Y` + waterfall$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
waterfall$Average_X <- as.numeric(waterfall$Average_X)
waterfall$Average_Y <- as.numeric(waterfall$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_w <- waterfall[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_w <- kmeans(data_to_cluster_w, centers = 3)

# Add cluster assignments to original data
waterfall$cluster <- k3_w$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(waterfall$Average_X, waterfall$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_waterfall <- ggplot(waterfall, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Waterfall - Average")

# Print the heatmap
print(heatmap_waterfall)


