### Install packages
install.packages("vegan")
install.packages("grid")

### Load packages
library(vegan)
library(ggplot2)
library(grid)
library(readxl)
library(tidyverse)

### Load and format data 
data <- read_excel("fish-data.xlsx")
df <- as.data.frame(data)
matrix <- data %>%
  tibble::column_to_rownames("Sample") # make sure row names are unique

### Transform the data 
sqrt_matrix <- sqrt(matrix)

### Running an NMDS
mds <- metaMDS(sqrt_matrix)
plot(mds) # simple plot

### Load your variables
fish <- read_excel("fish-variables.xlsx") # load your veg variable data
fish1 <- fish %>%
  tibble::column_to_rownames("Sample")
fish_df <- as.data.frame(fish1)

### Running adonis 
adon.results <- adonis2(sqrt_matrix ~ fish_df$Tide, method="bray", perm=999)
print(adon.results) # model results - tide looks significant 

### Make sure to test the dispersion of your model and data
dis <- vegdist(sqrt_matrix) # transformed matrix data 
test <- betadisper(dis, fish_df$Tide) # test for homogeneity of group dispersion 
anova(test) # not significant - which is good
permutest(test, permutations = 999, pairwise=TRUE)
TukeyHSD(test) # same test as above, just different output 

### Make a more advanced plot
nmds_coords <- as.data.frame(mds$points)
tide <- factor(c("High", "High", "Low", "High", "High", "Low", "Low")) # add tide data as a new column
nmds_coords$tide <- tide

NMDSplot <- ggplot(nmds_coords, aes(x = MDS1, y = MDS2, color = tide)) +
  geom_jitter(width = 0.1, height = 0.1, size=3) + # adjust size of points
  labs(x = "NMDS1", y = "NMDS2", color = "Tide") +
  scale_color_manual(values = c("High" = "blue", "Low" = "green")) + # choose the colors you want
  theme_linedraw() # choose your favorite theme

NMDSplot + 
  theme(axis.text = element_text(size = 12)) + # edit text size
  theme(axis.title = element_text(size = 16)) +
  theme(legend.text = element_text(size = 12)) +
  theme(legend.title = element_text(size = 16))

## Save this "prettier" plot for your report 
ggsave("fish-NMDS-example.png", plot = NMDSplot, width = 8, height = 6, dpi = 300) # adjust size & resolution
