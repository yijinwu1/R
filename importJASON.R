#jason

install.packages("jsonlite")
library(jsonlite)
pizza <- fromJSON('http://www.jaredlander.com/data/PizzaFavorites.json')
pizza
