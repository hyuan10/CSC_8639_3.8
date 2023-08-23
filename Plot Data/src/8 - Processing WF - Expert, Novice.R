########## Expert
# Load the gaze data
Waterfall_e_1 <- read_csv("data/Waterfall/gaze_data_000_20230806_025154.csv", col_names = TRUE)
Waterfall_e_2 <- read_csv("data/Waterfall/gaze_data_002_20230808_162820.csv", col_names = TRUE)
Waterfall_e_3 <- read_csv("data/Waterfall/gaze_data_008_20230813_174728.csv", col_names = TRUE)
Waterfall_e_4 <- read_csv("data/Waterfall/gaze_data_009_20230813_180059.csv", col_names = TRUE)
Waterfall_e_5 <- read_csv("data/Waterfall/gaze_data_011_20230814_113124.csv", col_names = TRUE)
Waterfall_e_6 <- read_csv("data/Waterfall/gaze_data_014_20230814_140954.csv", col_names = TRUE)

# Combine df
Waterfall_e <- list(Waterfall_e_1,Waterfall_e_2,Waterfall_e_3,Waterfall_e_4,Waterfall_e_5,Waterfall_e_6)
Waterfall_e <- bind_rows(Waterfall_e)

# Remove NaN rows from the data
Waterfall_e <- Waterfall_e[complete.cases(Waterfall_e), ]

# Calculate the average gaze point between left and right eyes
Waterfall_e$Average_X <- (Waterfall_e$`Left Eye X` + Waterfall_e$`Right Eye X`) / 2
Waterfall_e$Average_Y <- ((Waterfall_e$`Left Eye Y` + Waterfall_e$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
Waterfall_e$Average_X <- as.numeric(Waterfall_e$Average_X)
Waterfall_e$Average_Y <- as.numeric(Waterfall_e$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_we <- Waterfall_e[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_we <- kmeans(data_to_cluster_we, centers = 3)

# Add cluster assignments to original data
Waterfall_e$cluster <- k3_we$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(Waterfall_e$Average_X, Waterfall_e$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_Waterfall_e <- ggplot(Waterfall_e, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Waterfall - Expert")

# Print the heatmap
print(heatmap_Waterfall_e)


########## Novice

# Load the gaze data
Waterfall_n_1 <- read_csv("data/Waterfall/gaze_data_001_20230808_134420.csv", col_names = TRUE)
Waterfall_n_2 <- read_csv("data/Waterfall/gaze_data_003_20230808_163400.csv", col_names = TRUE)
Waterfall_n_3 <- read_csv("data/Waterfall/gaze_data_004_20230808_165046.csv", col_names = TRUE)
Waterfall_n_4 <- read_csv("data/Waterfall/gaze_data_005_20230808_170227.csv", col_names = TRUE)
Waterfall_n_5 <- read_csv("data/Waterfall/gaze_data_006_20230808_171342.csv", col_names = TRUE)
Waterfall_n_6 <- read_csv("data/Waterfall/gaze_data_007_20230813_171739.csv", col_names = TRUE)
Waterfall_n_7 <- read_csv("data/Waterfall/gaze_data_010_20230813_180706.csv", col_names = TRUE)
Waterfall_n_8 <- read_csv("data/Waterfall/gaze_data_012_20230814_114046.csv", col_names = TRUE)
Waterfall_n_9 <- read_csv("data/Waterfall/gaze_data_014_20230814_140954.csv", col_names = TRUE)

# Combine df
Waterfall_n <- list(Waterfall_n_1,Waterfall_n_2,Waterfall_n_3,Waterfall_n_4,Waterfall_n_5,Waterfall_n_6,Waterfall_n_7,Waterfall_n_8,Waterfall_n_9)
Waterfall_n <- bind_rows(Waterfall_n)

# Remove NaN rows from the data
Waterfall_n <- Waterfall_n[complete.cases(Waterfall_n), ]

# Calculate the average gaze point between left and right eyes
Waterfall_n$Average_X <- (Waterfall_n$`Left Eye X` + Waterfall_n$`Right Eye X`) / 2
Waterfall_n$Average_Y <- ((Waterfall_n$`Left Eye Y` + Waterfall_n$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
Waterfall_n$Average_X <- as.numeric(Waterfall_n$Average_X)
Waterfall_n$Average_Y <- as.numeric(Waterfall_n$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_wn <- Waterfall_n[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_wn <- kmeans(data_to_cluster_wn, centers = 3)

# Add cluster assignments to original data
Waterfall_n$cluster <- k3_wn$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(Waterfall_n$Average_X, Waterfall_n$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_Waterfall_n <- ggplot(Waterfall_n, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Waterfall - Novice")

# Print the heatmap
print(heatmap_Waterfall_n)


