# Summarize survey responses
# packages
library(tidyverse)

# Read in data
raw_dat <- read.csv("~/ROV Lesson/Denny MS Rockfish Survey Responses.MBA final.csv")

# Keep only score columns
dat <- raw_dat%>%
  transmute(survey_type, )

# Reshape

