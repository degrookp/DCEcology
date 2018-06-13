

# EXTRA
# An example of R functions interacting with databases
# https://github.com/inbo/etn/blob/master/R/get_animals.R
# 
# How to secure your credentials when interacting with databases
# https://db.rstudio.com


library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)

download.file(url = "https://ndownloader.figshare.com/files/2292171",
              destfile = "data/portal_mammals.sqlite", mode = "wb")

# create a database connection

DBConnection <- DBI::dbConnect(RSQLite::SQLite(), "data/portal_mammals.sqlite")

str(DBConnection)

??src_dbi

dbplyr::src_dbi(DBConnection)

# interact with tables from database

surveys <- tbl(DBConnection, "surveys")
plots <- tbl(DBConnection, "plots")
species <- tbl(DBConnection, "species")
head(surveys)

?show_query

d <- surveys %>%
  filter(year == 2002 & weight > 220)
show_query(d)

show_query (surveys %>%
  mutate(mean_weight = weight/1000))


# Combining groupby and mutate, enables aggregations, while keeping the same amount of rows in your data.frame
df %>% 
  groupby(SOME_VAR) %>%
  mutate(new_col = AGG(...))



# Make a subset of your data and plot it
surveys2002 <- surveys %>% 
  filter(year == 2002) %>% 
  as.data.frame() 

library(ggplot2)  
ggplot(data = surveys2002, aes(weight, colour = "red")) +
  stat_density(geom = "line", size = 2, position = "identity") +
  theme_classic() +
  theme(legend.position = "none")

surveys %>% 
  filter(year == 2002) %>% 
  as.data.frame() %>%
  ggplot(aes(weight, colour = "red")) +
  stat_density(geom = "line", size = 2, position = "identity") +
  theme_classic() +
  theme(legend.position = "none")



















