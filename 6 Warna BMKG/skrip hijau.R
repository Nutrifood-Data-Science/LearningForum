rm(list=ls())
gc()

library(EBImage)
library(dplyr)
library(tidyr)
library(parallel)

ncore = detectCores()

# sekarang kita akan ambil semua images yang sudah diambil dari website BMKG
setwd("~/LearningForum/6 Warna BMKG/gambar mentah")
bmkgs = list.files()

# membuat functions untuk mengukur seberapa hijau
hijaukan = function(input){
  # Load the image
  img = readImage(input)
  
  # Get the dimensions of the image array
  img_dims = dim(img)
  
  # ambil green channel saja
  green_channel = img[,,2]
  
  # This gives a single value representing the overall greenness
  average_green_intensity = mean(green_channel)
  
  # metric ini mengukur berapa banyak pixel yang berada di atas threshold hijau
  green_threshold       = 0.8
  high_green_pixels     = sum(green_channel > green_threshold)
  total_pixels          = nrow(green_channel) * ncol(green_channel) # or length(green_channel)
  proportion_high_green = high_green_pixels / total_pixels
  
  # metric ini mengukur dominasi hijau comapred to blue dan red 
  red_channel  = img[,,1]
  blue_channel = img[,,3]
  # Calculate per-pixel green dominance score (G - R + G - B) / 2
  # Values range from -1 (no green relative to others) to +1 (full green relative to others)
  green_dominance_per_pixel = ( (green_channel - red_channel) + (green_channel - blue_channel) ) / 2
  average_green_dominance   = mean(green_dominance_per_pixel)
  
  # membuat output
  output = data.frame(nama = gsub(".png","",input),
                      average_green_intensity,proportion_high_green,average_green_dominance)
  return(output)
}

# kita hitung semua hijau yang ada
temp     = mclapply(bmkgs,hijaukan,mc.cores = ncore)
df_hijau = data.table::rbindlist(temp) %>% as.data.frame()

# berikutnya kita rapikan namanya untuk jadi tanggal
df_hijau = 
  df_hijau %>% 
  separate(nama,into = c("bulan","tahun"),
           sep = "\\-") %>% 
  mutate(tanggal = 1) %>% 
  mutate(tgl = paste(tanggal,bulan,tahun,sep = "-"),
         tgl = as.Date(tgl,"%d-%m-%y")) %>% 
  select(-tanggal,-bulan,-tahun) %>% 
  arrange(tgl)

setwd("~/LearningForum/6 Warna BMKG")
save(df_hijau,file = "data.rda")
