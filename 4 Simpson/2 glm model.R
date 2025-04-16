rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(janitor)

load("hasil_survey.rda")

df_survey %>% tabyl(last) %>% adorn_pct_formatting()

df_survey %>% tabyl(ses,last) %>% 
  adorn_percentages(denominator = "row") %>% 
  adorn_pct_formatting()

df_survey %>% tabyl(usia,last) %>% 
  adorn_percentages(denominator = "row") %>% 
  adorn_pct_formatting()

df_survey %>% tabyl(gender,last) %>% 
  adorn_percentages(denominator = "row") %>% 
  adorn_pct_formatting()

library(caret)
var_terlibat = c("gender","usia","ses")
df_model = df_survey %>% select(all_of(var_terlibat))

target_var = ifelse(df_model$last == "ya",1,0)

dmy <- dummyVars(" ~ gender + usia + ses", data = df_model)
data_encoded <- data.frame(predict(dmy, newdata = df_model))

data_encoded = data_encoded %>% mutate(target = target_var)

model = glm(target ~ .,data = data_encoded,family = "binomial")

summary(model)











