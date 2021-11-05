# Estimate rockfish population
library(ggplot2)

# Class
class_name <- "Denny_Period2"

# Area swept in video
area_swept_km2 <- 0.00025

# Total area of high relief habitat in puget sound
area_high_relief_km2 <- 105

# Load rockfish data
rockfish_data <- read.csv(file = "rockfish_counts.csv")

# Equation for the area swept method
rockfish_data$population <- (rockfish_data$High.Relief / area_swept_km2) * area_high_relief_km2

mean(rockfish_data$population)

max(table(cut(rockfish_data$population, seq(500000,5200000, 500000)))) + 1


# Make plot
rockfish_histogram <- ggplot(data = subset(rockfish_data, population < 15000000),
                             aes(x = population/1e6)) +
  geom_histogram(breaks = seq(500000,5200000, 500000)/1e6,
                 fill = "#FF6000") +
  geom_vline(aes(xintercept = mean(population)/1e6), 
             linetype = 2) +
  scale_x_continuous(name = "Rockfish population (millions)", 
                     limits = c(0,5e6)/1e6) +
  scale_y_continuous(name = "Frequency", 
                     limits = c(0, max(table(cut(rockfish_data$population, seq(500000,5200000, 500000)))) + 1),
                     expand = c(0,0)) +
  geom_text(aes(x = round(mean(population)/1e6, 2), 
                y = max(table(cut(population, seq(500000,5200000,500000)))) + 1, 
                label = paste0("Average = ", 
                               round(mean(population)/1e6, 2), " million")), 
            hjust = -0.1, 
            vjust = 1.5) +
  theme_bw() +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 18))

png(paste0("./plots/", class_name, "_", "population_histogram.png"), width = 6, height = 6, units = "in", res = 300)
print(rockfish_histogram)
dev.off()

  