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
data <- read_excel("vegetation-data.xlsx")
df <- as.data.frame(data)
matrix <- df %>%
  tibble::column_to_rownames("sample") # make sure row names are unique

### Running an NMDS
mds <- metaMDS(matrix)
plot(mds) # simple plot
  
### Load your variables
veg <- read_excel("vegetation-variables.xlsx") # load your veg variable data
veg1 <- veg %>%
  tibble::column_to_rownames("sample")
veg_df <- as.data.frame(veg1)

### Running adonis 
adon.results <- adonis2(matrix ~ veg_df$vegetation, method="bray", perm=999)
print(adon.results) # model results - looks significant 

### Make sure to test the dispersion of your model and data
dis <- vegdist(matrix) # original matrix data 
test <- betadisper(dis, veg_df$vegetation) # test for homogeneity of group dispersion 
anova(test) # not significant - which is good
permutest(test, permutations = 999, pairwise=TRUE)
TukeyHSD(test) # same test as above, just different output 

### Make a more advanced plot
nmds_coords <- as.data.frame(mds$points)
veg <- factor(c("Zostera", "Zostera", "Zostera", "Zostera", "Lyngbya", "Lyngbya", "Lyngbya", "Lyngbya")) # add veg data as a new column
nmds_coords$veg <- veg

NMDSplot <- ggplot(nmds_coords, aes(x = MDS1, y = MDS2, color = veg)) +
  geom_point(size=3) + # adjust size of points
  labs(x = "NMDS1", y = "NMDS2", color = "Vegetation type") +
  scale_color_manual(values = c("Lyngbya" = "blue", "Zostera" = "green")) + # choose the colors you want
  theme_linedraw() # choose your favorite theme

NMDSplot + 
theme(axis.text = element_text(size = 12)) + # edit text size
  theme(axis.title = element_text(size = 16)) +
  theme(legend.text = element_text(size = 12)) +
  theme(legend.title = element_text(size = 16))

## Save this "prettier" plot for your report 
ggsave("example-NMDSplot.png", plot = NMDSplot, width = 8, height = 6, dpi = 300) # adjust size & resolution
