library(tidyverse)
library(viridis)

serengeti = read_csv("http://datadryad.org/bitstream/handle/10255/dryad.86348/consensus_data.csv")
serengeti.behaviours = serengeti[10:11] # a data frame/tibble is a list of columns/variables!
plot_by_species = split(serengeti[10:11], serengeti$Species) #split by species
to_plot = plot_by_species[1:10] #so I don't forget to subset


##############
#
### Q1: apply the summary function to each of the different species
#
###############

typeof(plot_by_species)

lapply(plot_by_species[1:10], summary)

##############
#
### Q2: apply the plot function to the first 10 species
### Pair-intermediate: can you plot the species name as the title of the plot?
#
###############
# and have the names of the species on the given plots


##############
#
#Matt B's answer
#
##############

# the simplest by far... but it doesn't use lapply just good old iteration
# his notes:
##A lot of people suggested the use of function (anonymous and otherwise)
##However, iterating through a very simple for loop does the trick 
##The code is easier to learn/write, there's really no need to get fancy
##This for loop works like a dream!!

par(mfrow=c(2,5))
for(i in 1:length(to_plot)){
  plot(to_plot[[i]], main = names(to_plot[i]))
}

##############
#
#Jonathan Kennel's answer
#
###############


plot_by_species = split(serengeti, serengeti$Species) #split by species

par(mfrow=c(2,5))

lapply(plot_by_species[1:10], 
		function(x) plot(Standing~Resting, x, main = Species[1]))



##############
#
#Nia's solution
#
###############

# I can follow the solution below better
# we are applying the function to the list of names, where each list of
# names are used to call the particular subset of the serengeti.Species2 list

# the x in function(x) is c('aardvark' 'aardwolf'... etc.) and it is calling the serengeti.Species2
# list member correspnding to the name, and plotting it while applying the label to the plot


#Split dataset on species and extract columns 10 and 11 (behaviours)
serengeti.Species2 = split(serengeti[10:11], serengeti$Species)
 
#Set up multi-paneled plot

 
#Plots 1-10 with name
par(mfrow=c(2,5))
lapply( names(serengeti.Species2[1:10]), 
		function(x) plot(serengeti.Species2[[x]], main = x))


##############
#
# Cam Solution 1
#
###############

# this is the same as Matt B's but utilizes a function to make the plot
# just abstracted the plot away on preference more then anything. Matt's answer K.i.s.s.


#make a function that plots the data and adds a name
behaviour_name_plot = function(data){
  plot(data[[1]], main=names(data) )
} 


#test the function
#passes my unit test and does what I expect
behaviour_name_plot(to_plot[2])

#but when I lapply it... the scope is the level below the names of the list
# which is not expected. It puts the column names as the title!
# so my solution to get the names on the plot is no good with lapply!
par(mfrow=c(2,5))
lapply(to_plot, behaviour_name_plot)


#but if I loop over them it works as I would expect
#so lapply and loops are not as equivalent as I would like

par(mfrow=c(2,5))
for(i in 1:10){
  behaviour_name_plot(to_plot[i])
}


##############
#
# Cam Solution 2
#
###############

# by making the function accept 2 arguments, I can pass
# the names of the plots and the plot data into the function.
# I then use mapply to run the function with the two sets of variables passed in
?mapply


apply_behaviour_name_plot = function(data, name_dat){
  plot(data[[1]], main=name_dat, xlab=names(data)[1], ylab=names(data[2]) )
} 

par(mfrow=c(2,5))

mapply(apply_behaviour_name_plot, to_plot, names(to_plot))


#things I don't like:

# mapply is format: mapply(function, data)
# lapply is format: lapply(data, function)
# why are these opposite?


#im making a change to my homework!


