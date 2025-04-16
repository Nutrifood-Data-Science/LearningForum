rm(list = ls())
gc()

library(dplyr)
library(tidyr)
library(rvest)

setwd("~/LearningForum/5 Mamikos")

url = "Cari Kost di Sekitarmu, Booking Langsung Kost Terdekat.html"

baca = url %>% read_html()

nama_tempat = baca %>% html_nodes(".rc-info__name") %>% html_text() %>% stringr::str_trim()
area        = baca %>% html_nodes(".bg-c-text--body-1") %>% html_text() %>% stringr::str_trim()
area        = area[!grepl("diskon|promo",area,ignore.case = T)]
harga       = baca %>% html_nodes(".rc-price__text") %>% html_text() %>% stringr::str_trim()
harga       = gsub("[^0-9]","",harga) %>% as.numeric()

df_raw = 
  data.frame(nama_tempat,area,harga) %>% 
  mutate(area = gsub("kecamatan ","",area,ignore.case = T)) %>% 
  mutate(nama_cari = paste(area,"Surabaya, Indonesia",sep = ", "))

# sekarang kita geocoding
library(tidygeocoder)
nama_area = df_raw %>% pull(nama_cari) %>% unique() %>% sort()

# geocoding
address_single = data.frame(address = nama_area)
osm_output = geo(
  address = nama_area, 
  method  = "osm",
  lat     = latitude, 
  long    = longitude, 
  full_results = T
)

# balikin ke df_raw
df_referensi = osm_output %>% select(address,latitude,longitude) %>% rename(nama_cari = address)

nhub_sby = c(112.744989,-7.2931052)

library(osrm) 

hitung_jarak = function(input){
  rute = 
    osrmRoute(src = c(input[1],input[2]),
              dst = c(nhub_sby[1], nhub_sby[2]),
              overview = "full",
              osrm.profile    = "car")
  
  output = list(durasi = rute$duration,
                jarak  = rute$distance)
  
  return(output)
}

df_referensi = df_referensi %>% mutate(jarak = 0,durasi = 0)

for(i in 1:9){
  input = c(df_referensi$longitude[i],df_referensi$latitude[i])
  hit_  = hitung_jarak(input)
  df_referensi$durasi[i] = hit_$durasi
  df_referensi$jarak[i]  = hit_$jarak
}

df_final = merge(df_raw,df_referensi)

df_sum = 
  df_final %>% 
  group_by(area) %>% 
  summarise(mean_harga = mean(harga),
            median_harga = median(harga),
            mean_jarak = mean(jarak),
            mean_durasi = mean(durasi)) %>% 
  ungroup()

save(df_raw,df_final,df_sum,file = "saved.rda")
