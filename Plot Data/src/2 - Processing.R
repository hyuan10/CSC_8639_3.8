# Load the required libraries
library(ggplot2)
library(RColorBrewer)
library(readr)


# Load the gaze data
data <- read_csv("data/gaze_data.csv", col_names = FALSE)

col_names <- c("Left Eye X", "Left Eye Y", "Right Eye X", "Right Eye Y")

colnames(data) <- col_names

# Removing NaN from the data
data <- data[complete.cases(data), ]

# Calculate the average gaze point between left and right eyes
data$Average_X <- (data$`Left Eye X` + data$`Right Eye X`) / 2
data$Average_Y <- (data$`Left Eye Y` + data$`Right Eye Y`) / 2

# Create the heatmap for the average gaze points with smaller circles (h = 0.02) and without labels, grid, and legend
average_gaze_heatmap <- ggplot(data, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.08) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  theme_void() +
  theme(legend.position = "none")

# Print the heatmap
print(average_gaze_heatmap)

