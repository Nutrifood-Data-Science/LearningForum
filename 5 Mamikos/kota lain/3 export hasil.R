rm(list=ls())
gc()

setwd("~/LearningForum/5 Mamikos/kota lain/scraped mamikos")

library(dplyr)
library(tidyr)
library(parallel)

ncore = detectCores()

rdas = list.files()

ambilin = function(input){
  load(input)
  nama_df = gsub(".rda","",input)
  df_raw  = df_raw %>% mutate(kota = nama_df)
  nama_df = paste0("df_",nama_df)
  assign(nama_df,df_raw)
}

df_mamikos = mclapply(rdas,ambilin,mc.cores = ncore)

df_mamikos = 
  data.table::rbindlist(df_mamikos,fill = T) %>% 
  as.data.frame() %>% 
  select(-area,-nama_cari)

df_mamikos %>% 
  filter(grepl("mandi dalam",fasilitas,ignore.case = T)) %>% 
  filter(grepl("ac",fasilitas,ignore.case = T)) %>% 
  filter(grepl("duduk",fasilitas,ignore.case = T)) %>% 
  openxlsx::write.xlsx(file = "~/LearningForum/5 Mamikos/kota lain/results.xlsx")

# Tempat tidur
# furnish
# AC
# Kloset duduk
# Kamar mandi dalam
# Area parkir mobil