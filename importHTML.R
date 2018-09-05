#html

install.packages("rvest")
library(rvest)
ribalta <- read_html('http://www.jaredlander.com/data/ribalta.html')
ribalta

#choose ul --> span
ribalta %>% html_nodes('ul') %>% html_nodes('span')

#html class:.XXX, id:#xxx
ribalta %>% html_nodes('.street')

#no html tag
ribalta %>% html_nodes('.street') %>% html_text()

#attributes value
ribalta %>% html_nodes('#longitude') %>% html_attr('value')

#sixth table
ribalta %>% html_nodes('table.food-items') %>% magrittr::extract2(5) %>% html_table()
