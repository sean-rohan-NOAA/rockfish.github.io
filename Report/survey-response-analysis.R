# Summarize survey responses
# packages
library(tidyverse)

# Read in data
raw_dat <- read.csv("~/ROV Lesson/rockfish.github.io/Report/response data/Denny MS Rockfish Survey Responses.csv")

# Keep only survey_type and score columns
dat <- raw_dat%>%
  transmute(survey_type, across(c(Q1_score, Q2_score, Q3_score, Q4_score, Q5_score), as.numeric))

dat$survey_type <- factor(dat$survey_type, levels=c("pre", "post")) #convert to factor

# Reshape data for quick plot
dat_L <- pivot_longer(dat, cols = c(Q1_score, Q2_score, Q3_score, Q4_score, Q5_score), names_to = "question", values_to = "score")

dat_L$score <- factor(dat_L$score, levels = c("0", "1", "2"))

# Quick plot
ggplot(dat_L)+
  geom_bar(aes(question, fill=score), stat = "count")+
  scale_fill_manual(values = c("darkred", "light green", "green"))+
  coord_flip()+
  facet_wrap(~survey_type, nrow = 2)
