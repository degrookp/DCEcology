library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

# nested

surveys_sml <- select(filter(surveys, weight < 5), species_id, sex)

# shortcut pipe: ctr, shift, m, of command shift m

d <- surveys %>%
  select(plot_id, species_id, weight, year) %>%
  filter(year == 1995 & weight < 5)

d <- surveys %>% 
  select(year, sex, weight) %>% 
  filter(year < 1995) %>% 
  mutate(kg = weight/1000)

d <- surveys %>%
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  select(species_id, hindfoot_half) %>%
  filter(hindfoot_half < 30) %>% 
  drop_na()
  

surveys %>% 
  drop_na() %>%
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  tail()

write_csv(d, path = "generated_data.csv")





