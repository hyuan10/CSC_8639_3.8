# Load the gaze data
PNL <- read_csv("data/PNL/gaze_data.csv", col_names = FALSE)

col_names <- c("Left Eye X", "Left Eye Y", "Right Eye X", "Right Eye Y")

colnames(PNL) <- col_names

# Removing NaN from the data
PNL <- PNL[complete.cases(PNL), ]

# Calculate the average gaze point between left and right eyes
PNL$Average_X <- (PNL$`Left Eye X` + PNL$`Right Eye X`) / 2
PNL$Average_Y <- (PNL$`Left Eye Y` + PNL$`Right Eye Y`) / 2

# Create the heatmap for the average gaze points
heatmap_PNL <- ggplot(PNL, aes(x = Average_X, y = Average_Y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", h = 0.03) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "YlOrRd")) +
  theme_minimal() +
  theme(legend.position = "none") +  
  scale_x_continuous(limits = c(0, 1)) +
  scale_y_continuous(limits = c(0, 1))

# Print the heatmap
print(heatmap_PNL)

