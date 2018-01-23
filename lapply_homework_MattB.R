##############################
## split-lapply combos
## Tutorial 01
##
## Karl Cottenie
##
## 2017-12-04
##
##############################

library(tidyverse)
library(viridis)
# + scale_color/fill_viridis(discrete = T/F)
theme_set(theme_light())

# Startup ends here

# Explore data set -----------------
serengeti = read_csv("http://datadryad.org/bitstream/handle/10255/dryad.86348/consensus_data.csv")
# For meta data on this data set, visit this link:
# http://datadryad.org/bitstream/handle/10255/dryad.86348/README.docx

##read_csv formats the data for you instead of read.csv

head(serengeti) #DO NOT NEED HEAD WITH read_csv!!!!!
serengeti
summary(serengeti)

# Almost all data sets have grouping variables, and you want to repeat something for each of the groups
# Welcome to the world of split-lapply

# Split the data on the species identity, what is a list? -----
serengeti.Site = split(serengeti, serengeti$SiteID)
serengeti.Site # This is now a list with as each element a subset of the original data set
serengeti.Site[[1]] # this is how you inspect an element of the list
summary(serengeti.Site[[1]])

##can also subset the dataset with view(dataframe) and filter

names(serengeti.Site) # explore the names

# RStudio option -----
# Use the object explorer
# go to the environment pane
# click on the search glass
# click on the down arrow, scroll, and arrow window

serengeti.Site$B07
serengeti.Site[["B09"]]

summary(serengeti.Site$F08)

### Pair: How many rows and columns are there in F08?
### Pair: What was the first and last day that the camera trap took pictures?

# difference between [] and [[]] for a list -----
serengeti.Site[1] #This is a list with one element!
summary(serengeti.Site[1])
serengeti.Site[[1]]
summary(serengeti.Site[[1]])

### Pair: Can you predict what these two lines will do?
serengeti.Site[1:4]
serengeti.Site[[1:4]]
### Pair: Why do they behave differently?

# Apply some function of interest to all elements in a list, lapply ----
dim(serengeti)
dim(serengeti.Site) # dim only works for a matrix-like object
length(serengeti.Site) # this is how you check how many elements there are in a list
dim(serengeti.Site[[1]]) # how many pictures from the first site?
dim(serengeti.Site[[2]]) # how many pictures from the second site?

### Pair: before you run the next line, what word should replace the XXX:
dim(serengeti.Site[[length(serengeti.Site)]]) # how many pictures from the XXX site?

# this is where the magic happens
lapply(serengeti.Site, dim) 
# lapply: apply a function to a list
# the list: serengeti.Site
# the function: dim

### Pair: how would you check that the lapply line of code above worked correctly?

# apply some function of interest to all elements in a list, for loop -----
for (i in seq_along(serengeti.Site)) print(dim(serengeti.Site[[i]]))
# for: apply something to a sequence
# i in seq_along(serengeti.Site) is the sequence generator
# print(dim(serengeti.Site[[i]])) is the something, in this case asking for the dimensions

### Pair: why is the print() statement necessary?

# Applying some function to all elements in a list, and save the results -----

site.dim.lapply = lapply(serengeti.Site, dim) 
site.dim.lapply[[3]]
site.dim.lapply[3]

site.dim.for = list()                                 # 1. output of the loop
for (i in seq_along(serengeti.Site)) {                # 2. sequence to loop through
  site.dim.for[[i]] = dim(serengeti.Site[[i]])        # 3. body of the function
  # print(dim(serengeti.Sit[[i]]))                    # 4. body of function can be multiple lines
}

### Pair: how would you check that lapply and for-loop results are the same, using only the tools we have used so far?
site.dim.for[[5]]
site.dim.lapply[[5]]

length(site.dim.for)
length(site.dim.lapply)

for (i in 1:length(site.dim.lapply)) { print(site.dim.for[[i]][1] - site.dim.lapply[[i]][1])}

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

