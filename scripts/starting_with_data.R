# https://grofwildjacht.inbo.be/

# https://github.com/inbo/git-course

#http://pad.software-carpentry.org/2018-06-12-bru-datacarpentry-inbo-elixir

library(tidyverse)

download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")

surveys <- read_csv("data/portal_data_joined.csv")

dim(surveys) 
nrow(surveys) 
ncol(surveys) 
head(surveys) 
tail(surveys) 
names(surveys)    
rownames(surveys)
str(surveys)
summary(surveys)

sex <- factor(c("male", "female", "male", "female"))
levels(sex)
nlevels(sex)

year_fct <- factor(c(1990, 1983, 2000, 1998, 1996))
as.numeric(year_fct)
year_fct <- factor(c(1990, 1983, 2000, 1998, 1996))
as.numeric(as.character(year_fct))
as.numeric(levels(year_fct))[year_fct]

surveys$sex <- as.factor(surveys$sex)
plot(surveys$sex)

levels(surveys$sex)

sex <- surveys$sex

levels(surveys$sex)[levels(surveys$sex)=="F"] <- "Female"
levels(surveys$sex)[levels(surveys$sex)=="M"] <- "Male"

# andere optie
levels(sex)[2:3] <- c("male", "female")

sex <- factor(sex, levels=c( "female", "male","undetermined"))

plot(surveys$sex)

library(lubridate)

my_date <- ymd("2015-01-01")
str(my_date)

# paste
eerste_dag <- "01-01"

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$datum <- ymd(paste(surveys$year, eerste_dag, sep = "-"))

my_date <- floor_date(as_date("2012", format = "%Y", tz = "UTC"), unit = "year")
year(my_date)

# check missing values

is_missing_date <- is.na(surveys$date)
is_missing_date

# find missing values from warning

date_columns <- c("year", "month", "day")
missing_dates <- surveys[is_missing_date, date_columns]

# visualisation
download.file("https://ndownloader.figshare.com/files/11930600?private_link=fe0cd1848e06456e6f38",
              "data/surveys_complete.csv")
surveys_complete <- read_csv("data/surveys_complete.csv")

ggplot(data = surveys_complete, aes(x = weight, y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.1)


ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, aes(colour = factor(plot_id))) +
  geom_boxplot()
  
ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  scale_y_log10() +
  geom_jitter(alpha = 0.3, aes(colour = factor(plot_id))) +
  geom_violin()

ggplot(surveys_complete, aes(x = species_id, y = hindfoot_length)) +
  scale_y_log10() +
  geom_boxplot() +
  geom_jitter(aes(colour = factor(plot_id)))


yearly_count <- surveys_complete %>%
  group_by(year, species_id) %>%
  count()

ggplot(yearly_count, aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~species_id, ncol = 4, scales = "free")


yearly_sex_count <- surveys_complete %>%
  group_by(year, species_id, sex) %>%
  count()

ggplot(yearly_sex_count, aes(x = year, y = n, colour = sex)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        text = element_text(size = 16),
        axis.text.x = element_text(colour = "skyblue", size = 12, angle = 90, hjust = 0.5)) +
  geom_line() +
  facet_wrap(~ species_id) +
  labs(title = "Observed species over time",
       subtitle = "Training",
       caption = "data carpentry",
       x = "Year of observation",
       y = "Number of observations")


grey_theme <-  theme(panel.grid = element_blank(),
                     text = element_text(size = 16),
                     axis.text.x = element_text(colour = "skyblue", size = 12, angle = 90, hjust = 0.5))

p <- ggplot(yearly_sex_count, aes(x = year, y = n, colour = sex)) +
  theme_bw() +
  grey_theme +
  geom_line() +
  facet_wrap(~ species_id) +
  labs(title = "Observed species over time",
       subtitle = "Training",
       caption = "data carpentry",
       x = "Year of observation",
       y = "Number of observations")
p
ggsave("plots/my_plot.png", width = 15, height = 10, dpi = 300)

d <- starwars

ggplot(d, aes(x = height, y = mass, colour = homeworld)) +
  geom_point(shape = 16) 
  
  
  
  
  
  
  
  
