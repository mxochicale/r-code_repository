#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly01.R
# FileDescription:
#
#
# Reference:
#           hpps://plot.ly/ggplot2/time-series
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#

# library(plotly)
library(ggplot2)


set.seed(12345)
Date <- seq( as.Date("2010/1/1"), as.Date("2014/1/1"), "week" )
Y <- rnorm(n=length(Date), mean=100, sd=1 )
df <- data.frame(Date,Y)

df$Year <- format(df$Date, "%Y")
df$Month <- format(df$Date, "%b")
df$Day <- format(df$Date, "%d")

df$MonthDay <- format(df$Date, "%d-%b")

df$CommonDate <- as.Date( paste0("2000-", format(df$Date, "%j")), "%Y-%j" )

ggplot(data=df,
      mapping = aes(x= CommonDate, y=Y, shape = Year, colour = Year)) +
      geom_point() +
      geom_line() +
      facet_grid(facets= Year ~ .) +
      scale_x_date( labels = function(x) format(x, "%d-%b"))

# ggplotly()
