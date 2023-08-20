# Load the survey results data
Results <- read_excel("data/Results.xlsx")

# Select only 2 columns for quads
quads <- Results[, c("How often do you review financial data?", "How often do you review data visualisations?")]

quads[is.na(quads)] <- 5

# Normalising data from -2 to 2
quads$`How often do you review financial data?` <- (quads$`How often do you review financial data?` -3)*-1
quads$`How often do you review data visualisations?` <- (quads$`How often do you review data visualisations?`-3)*-1

# Summarize the number of points at each coordinate
quads_summary <- quads %>% 
  group_by(`How often do you review financial data?`, `How often do you review data visualisations?`) %>% 
  summarize(count = n()) %>%
  ungroup()

# Plot
ggplot(quads_summary, aes(x=`How often do you review financial data?`, y=`How often do you review data visualisations?`, size=count)) + 
  geom_point(alpha = 0.7, colour = "blue") +  # added alpha for better visibility when points overlap
  geom_hline(yintercept = 0, linetype="solid", color = "black") +
  geom_vline(xintercept = 0, linetype="solid", color = "black") +
  theme_minimal() + 
  labs(x="How often do you review financial data?", y="How often do you review data visualisations?", title="Scatter Plot of Quads") + 
  scale_size_continuous(range = c(1, 8), guide = "legend") + # adjust point sizes
  xlim(-2, 2) + 
  ylim(-2, 2)
