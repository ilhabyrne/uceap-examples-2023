### ---- R plot examples for UC trip 2023 ---- ###

### Example 1 - simple scatterplot ###

## Create an example dataset
df <- data.frame(x = c(1, 2, 3, 4, 5), y = c(2, 4, 6, 8, 10))

## Plot a scatterplot using ggplot2
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  labs(x = "X-Axis", y = "Y-Axis")

### Example 2 - scatterplot with 4 categorical variables ###

## Create an example dataset 
df1 <- data.frame(
  x = rep(1:5, each = 4),
  y = c(2, 4, 6, 8, 10, 1, 3, 5, 7, 9, 0, 2, 4, 6, 8, 1, 2, 3, 4, 5),
  group = factor(rep(1:4, each = 5))
)

## Create a ggplot2 plot with multiple lines
ggplot(df1, aes(x = x, y = y, color = group)) +
  geom_line() +
  labs(x = "X-Axis", y = "Y-Axis") +
  scale_color_manual(values = c("red", "blue", "green", "purple"))  # Custom line colors

### Example 3 - simple barplot ###

## Create an example dataset
df2 <- data.frame(
  Category = c("A", "B", "C", "D"),
  Time = c("D","N", "D", "N"),
  Value = c(10, 15, 7, 12)
)

## Create a barplot using ggplot2
ggplot(df2, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity") +
  labs(x = "Category", y = "Value", fill = "Category") +
  theme_minimal()

## Create a stacked barplot using ggplot2 with 3 variables 
ggplot(df2, aes(x = Category, y = Value, fill = Time)) +
  geom_bar(stat = "identity") +
  labs(x = "Category", y = "Value", fill = "Category") +
  scale_fill_manual(values = c("N" = "red", "D" = "green")) +
  theme_minimal()

### Example 4 - stacked barplot ###

## Create an example dataset
df3 <- data.frame(
  Category = c("A", "B", "C", "D"),
  Value1 = c(10, 15, 7, 12),
  Value2 = c(8, 11, 5, 9)
)

## Create a stacked barplot
ggplot(df3, aes(x = Category)) +
  geom_bar(aes(y = Value1, fill = "Value1"), stat = "identity") +
  geom_bar(aes(y = Value2, fill = "Value2"), stat = "identity") +
  labs(x = "Category", y = "Value", fill = "Legend") +
  scale_fill_manual(values = c("Value1" = "blue", "Value2" = "red")) +
  theme_minimal()

## Remove stacks & have them side by side 
 # merge Value1 and Value2 into a Value column


ggplot(df, aes(x = Category, y = Value, fill = ColorVar)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Category", y = "Value", fill = "ColorVar", title = "Dodged Barplot with ColorVar") +
  scale_fill_manual(values = c("Red" = "red", "Green" = "green", "Blue" = "blue", "Yellow" = "yellow")) +
  theme_minimal()

ggplot(df3, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Category", y = "Value", fill = "Legend") +
  scale_fill_manual(values = c("Value1" = "blue", "Value2" = "red")) +
  theme_minimal()

### Example 5 - boxplot ###

### Save your fave plot(s) for your report
ggsave("example-barplot.png", plot = barplot, width = 10, height = 6, dpi = 300) # adjust size & resolution

### Example 6 - nMDS ###

#