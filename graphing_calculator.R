# graphing calculator

require(ggplot2)

# Plot a function without data (must specify range of x-axis)

#f <- function(x) sqrt(x)*10
f <- function(x) sin(x)
g <- function(x) sin(2*x)
h <- function(x) (sin(x) + sin(2*x))

# this provides the legend labels
colors <- c("sin(x)" = "red", "sin(2x)" = "blue", "sin(x) + sin(2x)" = "black")
# see also
https://www.statology.org/ggplot-manual-legend/
  
xMin <- 0
xMax <- 12

base <-
  ggplot() +
  xlim(xMin, xMax)

funGraph <- 
  base + 
  geom_function(fun = f, aes(color = "sin(x)")) +
  geom_function(fun = g, aes(color = "sin(2x)")) +
  geom_function(fun = h, aes(color = "sin(x) + sin(2x)")) +
                  labs(color = "Function") +
                  scale_color_manual(values = colors) +
  ggtitle("Function")

print(funGraph)

# Generate a data table and plot the data from the table

xvals <- seq(xMin, xMax, by=1)
yvals <- f(xvals)
df <- cbind(x=xvals, y=yvals)

dataGraph <- 
  base + 
  aes(xvals, yvals) + 
  geom_smooth() +
  ggtitle("data")

print(dataGraph)
