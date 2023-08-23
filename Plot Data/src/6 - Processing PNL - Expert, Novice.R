########## Expert
# Load the gaze data
PNL_e_1 <- read_csv("data/PNL/gaze_data_000_20230806_021656.csv", col_names = TRUE)
PNL_e_2 <- read_csv("data/PNL/gaze_data_002_20230808_135758.csv", col_names = TRUE)
PNL_e_3 <- read_csv("data/PNL/gaze_data_008_20230813_174213.csv", col_names = TRUE)
PNL_e_4 <- read_csv("data/PNL/gaze_data_009_20230813_175544.csv", col_names = TRUE)
PNL_e_5 <- read_csv("data/PNL/gaze_data_011_20230814_112649.csv", col_names = TRUE)
PNL_e_6 <- read_csv("data/PNL/gaze_data_014_20230814_140714.csv", col_names = TRUE)

# Combine df
PNL_e <- list(PNL_e_1,PNL_e_2,PNL_e_3,PNL_e_4,PNL_e_5,PNL_e_6)
PNL_e <- bind_rows(PNL_e)

# Remove NaN rows from the data
PNL_e <- PNL_e[complete.cases(PNL_e), ]

# Calculate the average gaze point between left and right eyes
PNL_e$Average_X <- (PNL_e$`Left Eye X` + PNL_e$`Right Eye X`) / 2
PNL_e$Average_Y <- ((PNL_e$`Left Eye Y` + PNL_e$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
PNL_e$Average_X <- as.numeric(PNL_e$Average_X)
PNL_e$Average_Y <- as.numeric(PNL_e$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_pe <- PNL_e[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_pe <- kmeans(data_to_cluster_pe, centers = 3)

# Add cluster assignments to original data
PNL_e$cluster <- k3_pe$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(PNL_e$Average_X, PNL_e$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_PNL_e <- ggplot(PNL_e, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("PNL - Expert")

# Print the heatmap
print(heatmap_PNL_e)


########## Novice

# Load the gaze data
PNL_n_1 <- read_csv("data/PNL/gaze_data_001_20230808_134037.csv", col_names = TRUE)
PNL_n_2 <- read_csv("data/PNL/gaze_data_003_20230808_162952.csv", col_names = TRUE)
PNL_n_3 <- read_csv("data/PNL/gaze_data_004_20230808_164451.csv", col_names = TRUE)
PNL_n_4 <- read_csv("data/PNL/gaze_data_005_20230808_165919.csv", col_names = TRUE)
PNL_n_5 <- read_csv("data/PNL/gaze_data_006_20230808_171002.csv", col_names = TRUE)
PNL_n_6 <- read_csv("data/PNL/gaze_data_007_20230813_171229.csv", col_names = TRUE)
PNL_n_7 <- read_csv("data/PNL/gaze_data_010_20230813_180426.csv", col_names = TRUE)
PNL_n_8 <- read_csv("data/PNL/gaze_data_012_20230814_113803.csv", col_names = TRUE)
PNL_n_9 <- read_csv("data/PNL/gaze_data_013_20230814_133051.csv", col_names = TRUE)

# Combine df
PNL_n <- list(PNL_n_1,PNL_n_2,PNL_n_3,PNL_n_4,PNL_n_5,PNL_n_6,PNL_n_7,PNL_n_8,PNL_n_9)
PNL_n <- bind_rows(PNL_n)

# Remove NaN rows from the data
PNL_n <- PNL_n[complete.cases(PNL_n), ]

# Calculate the average gaze point between left and right eyes
PNL_n$Average_X <- (PNL_n$`Left Eye X` + PNL_n$`Right Eye X`) / 2
PNL_n$Average_Y <- ((PNL_n$`Left Eye Y` + PNL_n$`Right Eye Y`) / 2) * -1

# Ensure columns are numeric
PNL_n$Average_X <- as.numeric(PNL_n$Average_X)
PNL_n$Average_Y <- as.numeric(PNL_n$Average_Y)

# Extract the relevant columns for clustering
data_to_cluster_pn <- PNL_n[, c("Average_X", "Average_Y")]

# Apply k-means clustering
set.seed(123)  # for reproducibility
k3_pn <- kmeans(data_to_cluster_pn, centers = 3)

# Add cluster assignments to original data
PNL_n$cluster <- k3_pn$cluster

# Calculate the density and retrieve top 3 density levels
dens <- kde2d(PNL_n$Average_X, PNL_n$Average_Y, n = 100)
top_levels <- sort(unique(dens$z), decreasing = TRUE)[1:3]

# Create a KDE plot and overlay contours for top 3 density levels
heatmap_PNL_n <- ggplot(PNL_n, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  stat_density_2d(geom = "contour", breaks = top_levels, color = "green", linewidth = 1) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  coord_cartesian(xlim = c(0, 1), ylim = c(-1, 0)) +
  theme_minimal() +
  theme(legend.position = "none") +
  ggtitle("PNL - Novice")

# Print the heatmap
print(heatmap_PNL_n)


