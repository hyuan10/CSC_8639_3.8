# Load the gaze data
sankey <- read_csv("data/sankey/gaze_data.csv", col_names = FALSE)

# Set column names
colnames(sankey) <- col_names

# Remove NaN rows from the data
sankey <- sankey[complete.cases(sankey), ]

# Calculate the average gaze point between left and right eyes
sankey$Average_X <- (sankey$`Left Eye X` + sankey$`Right Eye X`) / 2
sankey$Average_Y <- ((sankey$`Left Eye Y` + sankey$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
sankey$Average_X <- as.numeric(sankey$Average_X)
sankey$Average_Y <- as.numeric(sankey$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_s <- sankey[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_s <- kmeans(data_to_cluster_s, centers = 3)

# Add cluster assignments to original data
sankey$cluster <- k3_s$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(sankey$Average_X, sankey$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_sankey <- ggplot(sankey, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.09) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Sankey - Average")

# Print the heatmap
print(heatmap_sankey)


