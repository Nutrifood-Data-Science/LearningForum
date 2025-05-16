rm(list = ls())
gc()

library(dplyr)
library(tidyr)
library(rvest)

setwd("~/LearningForum/5 Mamikos/kota lain/raw")

nama_kota = rstudioapi::showPrompt(title = "Nama Kota",
                                   message = "Tulis nama kota:")

nama_file = paste0("~/LearningForum/5 Mamikos/kota lain/scraped/",
                   nama_kota,".rda")

url = list.files(full.names = T)

baca = url %>% read_html()

nama_tempat = baca %>% html_nodes(".rc-info__name") %>% html_text() %>% stringr::str_trim()
area        = baca %>% html_nodes(".bg-c-text--body-1") %>% html_text() %>% stringr::str_trim()
area        = area[!grepl("diskon|promo|cash|listrik|proma",area,ignore.case = T)]

janitor::tabyl(area)

harga       = baca %>% html_nodes(".rc-price__text") %>% html_text() %>% stringr::str_trim()
harga       = gsub("[^0-9]","",harga) %>% as.numeric()
fasilitas   = baca %>% html_nodes(".rc-facilities") %>% html_text()

df_raw = 
  data.frame(nama_tempat,area,harga,fasilitas) %>% 
  mutate(area = gsub("kecamatan ","",area,ignore.case = T)) %>% 
  mutate(nama_cari = paste(area,nama_kota,"Indonesia",sep = ", "))

save(df_raw,file = nama_file)
unlink(url)

# baru sampe surabaya
