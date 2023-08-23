########## Expert
# Load the gaze data
Sankey_e_1 <- read_csv("data/Sankey/gaze_data_000_20230806_021837.csv", col_names = TRUE)
Sankey_e_2 <- read_csv("data/Sankey/gaze_data_002_20230808_140129.csv", col_names = TRUE)
Sankey_e_3 <- read_csv("data/Sankey/gaze_data_008_20230813_174350.csv", col_names = TRUE)
Sankey_e_4 <- read_csv("data/Sankey/gaze_data_009_20230813_175934.csv", col_names = TRUE)
Sankey_e_5 <- read_csv("data/Sankey/gaze_data_011_20230814_112957.csv", col_names = TRUE)
Sankey_e_6 <- read_csv("data/Sankey/gaze_data_014_20230814_140830.csv", col_names = TRUE)

# Combine df
Sankey_e <- list(Sankey_e_1,Sankey_e_2,Sankey_e_3,Sankey_e_4,Sankey_e_5,Sankey_e_6)
Sankey_e <- bind_rows(Sankey_e)

# Remove NaN rows from the data
Sankey_e <- Sankey_e[complete.cases(Sankey_e), ]

# Calculate the average gaze point between left and right eyes
Sankey_e$Average_X <- (Sankey_e$`Left Eye X` + Sankey_e$`Right Eye X`) / 2
Sankey_e$Average_Y <- ((Sankey_e$`Left Eye Y` + Sankey_e$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
Sankey_e$Average_X <- as.numeric(Sankey_e$Average_X)
Sankey_e$Average_Y <- as.numeric(Sankey_e$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_se <- Sankey_e[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_se <- kmeans(data_to_cluster_se, centers = 3)

# Add cluster assignments to original data
Sankey_e$cluster <- k3_se$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(Sankey_e$Average_X, Sankey_e$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_Sankey_e <- ggplot(Sankey_e, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Sankey - Expert")

# Print the heatmap
print(heatmap_Sankey_e)


########## Novice

# Load the gaze data
Sankey_n_1 <- read_csv("data/Sankey/gaze_data_001_20230808_134224.csv", col_names = TRUE)
Sankey_n_2 <- read_csv("data/Sankey/gaze_data_003_20230808_163204.csv", col_names = TRUE)
Sankey_n_3 <- read_csv("data/Sankey/gaze_data_004_20230808_164634.csv", col_names = TRUE)
Sankey_n_4 <- read_csv("data/Sankey/gaze_data_005_20230808_170051.csv", col_names = TRUE)
Sankey_n_5 <- read_csv("data/Sankey/gaze_data_006_20230808_171134.csv", col_names = TRUE)
Sankey_n_6 <- read_csv("data/Sankey/gaze_data_007_20230813_171520.csv", col_names = TRUE)
Sankey_n_7 <- read_csv("data/Sankey/gaze_data_010_20230813_180541.csv", col_names = TRUE)
Sankey_n_8 <- read_csv("data/Sankey/gaze_data_012_20230814_113925.csv", col_names = TRUE)
Sankey_n_9 <- read_csv("data/Sankey/gaze_data_014_20230814_140830.csv", col_names = TRUE)

# Combine df
Sankey_n <- list(Sankey_n_1,Sankey_n_2,Sankey_n_3,Sankey_n_4,Sankey_n_5,Sankey_n_6,Sankey_n_7,Sankey_n_8,Sankey_n_9)
Sankey_n <- bind_rows(Sankey_n)

# Remove NaN rows from the data
Sankey_n <- Sankey_n[complete.cases(Sankey_n), ]

# Calculate the average gaze point between left and right eyes
Sankey_n$Average_X <- (Sankey_n$`Left Eye X` + Sankey_n$`Right Eye X`) / 2
Sankey_n$Average_Y <- ((Sankey_n$`Left Eye Y` + Sankey_n$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
Sankey_n$Average_X <- as.numeric(Sankey_n$Average_X)
Sankey_n$Average_Y <- as.numeric(Sankey_n$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_sn <- Sankey_n[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_sn <- kmeans(data_to_cluster_sn, centers = 3)

# Add cluster assignments to original data
Sankey_n$cluster <- k3_sn$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(Sankey_n$Average_X, Sankey_n$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_Sankey_n <- ggplot(Sankey_n, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("Sankey - Novice")

# Print the heatmap
print(heatmap_Sankey_n)


