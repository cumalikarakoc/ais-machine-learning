library(ggplot2)
library(RODBC)
library(dplyr)

sql_conn <- odbcConnect("SAS_ML_FILTERED")
bar_color <- "#54a684"

##histograms for continuous features
ggplot_cont <- function(df, column, x_name) {
   return (
    ggplot(data=df, aes(x = column)) +
      geom_histogram(
        binwidth = 1,
        aes(y = ..density..),
        color = "black",
        fill = bar_color
      ) +
      geom_density(alpha = 0.2) +
      geom_vline(
        aes(
          xintercept = mean(column, na.rm = TRUE),
          color = "mean"
        ),
        linetype = "dashed",
        size = 1
      ) +
      scale_color_manual(name = "statistics",
                         values = c(mean = "red")) +
      scale_x_continuous(name = x_name) +
      theme_bw()
  )
}

##barplots for categorical features
ggplot_cat <- function(df, column, x_name, breaks, text_angle=0) {
  return (
    ggplot(df, aes(x = column)) +
      geom_bar(color = "Black",
               fill = bar_color) +
      scale_y_continuous(name = "Count",
                         breaks = breaks) +
      theme_bw()+
      labs(x=x_name)+
      theme(axis.text.x = element_text(angle = text_angle, hjust = 1))
  )
}

