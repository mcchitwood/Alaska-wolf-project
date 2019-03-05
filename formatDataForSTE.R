# Formatting Alaska wolf data for STE
# Colter Chitwood and Anna Moeller
# 3/4/2019

# sldfjsadlfkj aslkjf sdv 
# Load packages
library(tidyverse)
library(lubridate)
library(TTE.STE.IS)

# Load clean database
# dat_raw <- read.csv("CleanDatabase.csv", stringsAsFactors = F)

# Load clean database as R Object
dat_raw <- readRDS("CleanDatabase.RDS")

# View it to see column names and dimensions
dat_raw
dim(dat_raw)

# Format data to match requirements of Anna's package
dat_proc <- dat_raw %>%
  # Make column names correct
  rename(cam = DeployID, datetime = Date) %>%
  # Add area column (need to get estimate camera viewshed?)
  add_column(a = 150)
  
# View it to see column names and dimensions
dat_proc
dim(dat_proc)  

# Find first and last photo by Year
pics_by_year <- dat_proc %>%
  group_by(Year, Wolf) %>%
  summarise(first = min(datetime),
            last = max(datetime))

# Find first and last photo by cam
pics_by_cam <- dat_proc %>%
  group_by(cam, Wolf) %>%
  summarise(first = min(datetime),
            last = max(datetime))

blah
################################################################### 
test <- dat_proc %>%
  group_by(cam, datetime, Wolf) %>%
  summarise(count = max(Count1))


# Make database of the area of each camera
lu <- a_lookup_fn(dat_proc)


# Create STE encounter history
