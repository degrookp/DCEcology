# https://grofwildjacht.inbo.be/


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



surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

# check missing values

is_missing_date <- is.na(surveys$date)
is_missing_date

# find missing values from warning

date_columns <- c("year", "month", "day")
missing_dates <- surveys[is_missing_date, date_columns]




