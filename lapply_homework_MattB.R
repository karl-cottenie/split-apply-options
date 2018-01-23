# Homework 01: -----
serengeti.behaviours = serengeti[10:11] # a data frame/tibble is a list of columns/variables!
summary(serengeti.behaviours)

### Pair: apply the summary function to each of the different species
##Only the behaviour data split by species
##This is how Nia and I decided to split up and summarise the data
behaviour_species = split(serengeti[10:11], serengeti$Species)
behaviour_species
summary(behaviour_species[[1]])


### Pair: apply the plot function to the first 10 species
##Using lapply to plot the first 10 species
##Nia and I thought this would be the easiest
par(mfrow =c(2,5))
lapply(behaviour_species[1:10], plot)

### Pair-intermediate: can you plot the species name as the title of the plot?
##Alot of people suggested the use of function (anonymous and otherwise)
##However, iterating through a very simple for loop does the trick 
##The code is easier to learn/write, there's really no need to get fancy
##This for loop works like a dream!!

for(i in 1:10){
  plot(behaviour_species[[i]], main = names(behaviour_species[i]))
}

