# Example gganimate

# install.packages("fixest"); install.packages("coefplot") ;
# library(fixest) ; library(coefplot); 
require(ggplot2) ; require(gganimate); 
require(magick);require(gifski); require(dplyr) 
require(tidyverse)

# Simulate some two way panel data 
unit  <- rep(1:100, each=20)
df <-  as.data.frame( unit )
df$time  <- rep(1:20, times=100)
df$x  <- runif(2000)- 0.5
df$y  <- runif(2000)*unit*0.2 + df$x * 3 + runif(2000)
df$x2 <- cos(df$time*10*df$unit*pi/180)


#...
df1 <- data.frame(df[1:60,])
theme_set(theme_bw())
p <- ggplot(df1, aes(x=time, y=y, group=unit, color=unit)) + geom_line()  + geom_point(size=2)
p + transition_reveal(time)

p <- ggplot(df1, aes(x=time, y=x2, group=unit, color=unit)) + geom_line()  + geom_point(size=2) 
p + transition_reveal(along=time)


animacion1 <- df1 %>%
  ggplot(aes(x=time, y=x2, group=unit, color=unit)) + 
  geom_line()  + 
  geom_point(size=2) +
  transition_reveal(along=time)
  view_follow()
animate(animacion1, width = 700, height = 432, fps = 6, duration = 10, rewind = FALSE)

# Plot a function  (first w/ a dummy dataset)
fun.1 <- function(x) x^2 + x
ggplot(data = data.frame(x = 0), mapping = aes(x = x)) +
  stat_function(fun = fun.1) + xlim(-5,5) 
