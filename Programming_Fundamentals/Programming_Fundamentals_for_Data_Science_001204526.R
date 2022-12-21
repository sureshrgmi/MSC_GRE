# Install Packages
install.packages("tidyverse")
install.packages("modeest")

# Import Libraries
library(tidyverse)
library(modeest)
library(ggplot2)

# List the columns from the "who" data frame
colnames(who)

###########################################################################
##################        Task1           #################################
###########################################################################

## 1.1
# Gathering all columns using pivot_longer
who1 <- pivot_longer(who, 5:60, names_to = "key", values_to="cases",
                     values_drop_na= T )

## 1.2
# Creating a new data frame who2 from who1
who2 <- who1

# Making variable names consistent
who2$key <- str_replace(who2$key, "newrel", "new_rel")


## 1.3
# Running the code
who3 <- who2 %>% separate(key, c("new", "type", "sexage"), sep = "_")

# Commenting the code
# who3 <- who2 %>% separate(key, c("new", "type", "sexage"), sep = "_")


## 1.4
# Separating sexage column into sex and age
who4 <- who3 %>% separate(sexage, c("sex", "age"), sep = "(?<=[A-Za-z])(?=[0-9])")


## 1.5
# Print first 5 rows of the data frame who4
head(who4, n=5)

# Print last 5 rows of the data frame who4
tail(who4, n=5)


## 1.6
# Export who4 as a CSV file to the local directory
write.csv(who4, "path_to_directory/who4.csv", row.names=FALSE)


###########################################################################
##################        Task2           #################################
###########################################################################

# View the Nile dataset
view(Nile)


## 2.1
# Mean
mean(Nile)

# Median
median(Nile)

# Mode
mfv(Nile)

# Variance
var(Nile)

# Standard Deviation
sd(Nile)


## 2.2
# Calculate Minimum Value
min(Nile)

# Calculate Maximum Value
max(Nile)

# Calculate Range
max(Nile, na.rm=TRUE) - min(Nile, na.rm=TRUE)


## 2.3
# Finding interquartile range (IQR)
IQR(Nile)

# Computing Quantiles
quantile(Nile)


## 2.4
# Histogram using built-in R functions
hist(Nile,
     main="Histogram showing flow of the river Nile",
     xlab=bquote("Annual flow (10"^"8"*" m"^"3"*")"),
     ylab="Frequency",
     col="blue",
     freq=TRUE
)


## 2.5
# Q-Q Plot using qqnorm and qqline
qqnorm(Nile, pch=1, main = "Flow of Nile River (Q-Q plot)",
       frame=TRUE, col="blue", xlab = "Quantiles",
       ylab = bquote("Annual flow (10"^"8"*" m"^"3"*")"),
       plot.it = TRUE, datax = FALSE)
qqline(Nile, col="red", lwd=2)



## 2.6
plot(Nile, 
     xlab = "Year",
     ylab = bquote("Annual flow (10"^"8"*" m"^"3"*")"),
     main = "Annual flow of Nile (1871-1970)",
     type = "b")

###########################################################################
##################        Task3           #################################
###########################################################################     

## 3.1     
# City vs Highway mpg
sp <- ggplot(mpg, aes(x = cty, y = hwy, colour = factor(manufacturer)))+
   geom_point(size=5) + ggtitle("Highway VS City (MPG)") +
   theme(plot.title = element_text(hjust = 0.5))+ xlab("City MPG") +
   ylab("Highway MPG") + scale_color_discrete("Manufacturers")
sp

# Creating a new dataframe with the average value
agg_mpg <- aggregate(cbind(cty,hwy) ~ manufacturer, data = mpg,
                     FUN = mean, na.rm = TRUE)
# City vs Highway mpg (Average Value)
sp <- ggplot(agg_mpg, aes(x = cty, y = hwy, colour = factor(manufacturer)))+
  geom_point(size=5) + ggtitle("Highway VS City (Average MPG)") +
  theme(plot.title = element_text(hjust = 0.5))+ xlab("City MPG") +
  ylab("Highway MPG") + scale_color_discrete("Manufacturers")
sp 


## 3.2
# Plotting City MPG vs Displ for different classes (Using facet_warp)
p <- ggplot(data = mpg, aes(x = displ, y = cty, color=class,
                            shape=cty<15)) +
  geom_point()+geom_point(color='darkblue')+
  scale_color_discrete("Class") +
  scale_shape_discrete("City MPG < 15")
p + facet_wrap(~class) +
  ggtitle("City MPG Vs Displ for different classes")+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab("Displacement") +
  ylab("City MPG")+geom_smooth(formula = y ~ x)



## 3.3
# City vs Highway MPF for different Classes
plot <- ggplot(mpg, aes(x= cty, y = hwy, color=class,
                        shape= displ>4)) +
  geom_point()+ scale_color_discrete("Class") +
  scale_shape_discrete("Displacement > 4")
plot + facet_grid(vars(drv), vars(cyl))+
  ggtitle("City MPG Vs Highway MPG different Classes")+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab("City MPG") + ylab("Highway MPG")

     