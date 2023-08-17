# Load the gaze data
PNL <- read_csv("data/PNL/gaze_data.csv", col_names = FALSE)

# Set column names
col_names <- c("Left Eye X", "Left Eye Y", "Right Eye X", "Right Eye Y")
colnames(PNL) <- col_names

# Remove NaN rows from the data
PNL <- PNL[complete.cases(PNL), ]

# Calculate the average gaze point between left and right eyes
PNL$Average_X <- (PNL$`Left Eye X` + PNL$`Right Eye X`) / 2
PNL$Average_Y <- ((PNL$`Left Eye Y` + PNL$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
PNL$Average_X <- as.numeric(PNL$Average_X)
PNL$Average_Y <- as.numeric(PNL$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_p <- PNL[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_p <- kmeans(data_to_cluster_p, centers = 3)

# Add cluster assignments to original data
PNL$cluster <- k3_p$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(PNL$Average_X, PNL$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_PNL <- ggplot(PNL, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("PNL - Average")

# Print the heatmap
print(heatmap_PNL)


