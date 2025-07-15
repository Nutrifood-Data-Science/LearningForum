rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(ggplot2)

setwd("~/LearningForum/8 IMW 2025")

file = "Airport Security Lane Planning Data.csv"

df = read.csv(file) %>% janitor::clean_names()

df = 
  df %>% 
  separate(date,
           into = c("date","hapus"),
           sep = " ") %>% 
  select(-hapus) %>% 
  mutate(timeline = paste(date,time)) %>% 
  mutate(timeline = strptime(timeline,format = "%d/%m/%Y %H:%M:%S")) %>% 
  mutate(people_processed = ifelse(people_processed == "NULL",
                                   0,people_processed)) %>% 
  mutate(lane_count = ifelse(lane_count == "NULL",
                             1,lane_count)) %>% 
  mutate(people_processed = as.numeric(people_processed),
         lane_count = as.numeric(lane_count)) %>% 
  mutate(date = as.Date(date,"%d/%m/%Y")) %>% 
  mutate(hari = lubridate::wday(date,label = T)) %>% 
  mutate(time = lubridate::parse_date_time(time,orders = "HMS"),
         time = format(time, "%H:%M:%S"))
  
df = 
  df %>% 
  mutate(total_in = queue_length + people_processed) %>% 
  mutate(service_rate = people_processed / lane_count,
         service_rate = service_rate / 5) 

df %>% head()

# str(df)

save(df,file = "~/LearningForum/8 IMW 2025/draft/data.rda")







