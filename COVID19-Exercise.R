# Install R package developed by Dr. Guangchuang Yu
#from Southern Medical University.
#This package allows us to access the latest data
#and historical data of cases of all countries, plot
#data on a map, and create various graphs

remotes::install_github("GuangchuangYu/nCov2019")

require(nCov2019)
require(dplyr)

#get a first impression of the dataset
#assign x and y
x <- get_nCov2019()
y <- load_nCov2019()

#check results for x
x

#check results for y
y

#view worldwide data
x['global',]

#create a global map using the data
install.packages("maps")
require(nCov2019)
require(dplyr)

x <- get_nCov2019()
x
plot(x)

#explore the data
#install DataExplore package from Github
devtools::install_github("boxuancui/DataExplorer")
library(DataExplorer)

#Data obtained by the get_nCov2019() function includes
#3 lists and 5 data frames. These are the latest data
#of confirmed patients, deaths and recovery cases in China 
#and across the world.
plot_str(x)

#load_nCov2019() includes 3 data frames
#first data frame named ‘data’ is Chinese historical data
#on the city level including numbers of confirmed cases,
#deaths, recovery and suspects
#second one named ‘province’ is aggregated data on the province level
#third data frame ‘global’ includes confirmed cases, deaths, and
#recovery of countries across the world
plot_str(y)

#summarize dataset
summary(x['global',])

# In case you do not have magrittr installed, please do so below
#install.packages("magrittr")
#library(magrittr)
#library(dplyr)

+#visualye global growth over time
#library(magick) -> if the package is not installed, then execute below code
install.packages("magick")
library(magick)

require(nCov2019)
require(dplyr)

y <- load_nCov2019()
d <- c(paste0("2020–08-", 1:31), paste0("2020–09–", 1:30))
img <- image_graph(1200, 700, res = 96)
out <- lapply(d, function(date){
  p <- plot(y, date=date,
            label=FALSE, continuous_scale=TRUE)
  print(p)
})
dev.off()
animation <- image_animate(img, fps = 2)
print(animation)
