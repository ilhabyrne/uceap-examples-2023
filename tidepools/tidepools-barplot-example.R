### R code for tide pool group 2023 ###

## Install required packages
install.packages("readxl")
install.packages("xlsx")
install.packages("ggplot2")
install.packages("tidyverse")

library(readxl)
library(tidyverse)
library(ggplot2)
library(xlsx)

## Set working directory and load file
setwd("/Users/ilhabyrne/Desktop/UC")
dat <- read_excel("data.xlsx")

## Format the data for plotting
dat1 <- dat[, c("organism", "num", "time")] #remove all unwanted columns
dat2 <- aggregate(num ~ organism + time, dat1, sum) #sum values
dat3 <- dat2 %>% filter(organism != "total")  #remove "total"

## Create a dodged bar plot
barplot <- ggplot(dat3, aes(x = organism, y = num, fill = time)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_cartesian(ylim=c(9,200)) +
  labs(y="Abundance", x="Taxa", fill="Time of Day") +
  scale_fill_manual(values = c("N" = "blue", "D" = "green")) +
  theme_classic()

barplot +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) # view barplot

## Save barplot for report
ggsave("example-tidepool-barplot.png", plot = barplot, width = 10, height = 6, dpi = 300) #save in high-res for report

