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

# membuat functions untuk mengukur seberapa biru
birukan = function(input){
  # Load the image
  img = readImage(input)
  
  # Get the dimensions of the image array
  img_dims = dim(img)
  
  # ambil blue channel saja
  blue_channel = img[,,3]
  
  # This gives a single value representing the overall blueness
  average_blue_intensity = mean(blue_channel)
  
  # metric ini mengukur berapa banyak pixel yang berada di atas threshold biru
  blue_threshold       = 0.8
  high_blue_pixels     = sum(blue_channel > blue_threshold)
  total_pixels         = nrow(blue_channel) * ncol(blue_channel) # or length(blue_channel)
  proportion_high_blue = high_blue_pixels / total_pixels
  
  # metric ini mengukur dominasi biru comapblue to blue dan blue 
  red_channel   = img[,,1]
  green_channel = img[,,2]
  # Calculate per-pixel blue dominance score (G - R + G - B) / 2
  # Values range from -1 (no blue relative to others) to +1 (full blue relative to others)
  blue_dominance_per_pixel = ( (blue_channel - red_channel) + (blue_channel - green_channel) ) / 2
  average_blue_dominance   = mean(blue_dominance_per_pixel)
  
  # membuat output
  output = data.frame(nama = gsub(".png","",input),
                      average_blue_intensity,proportion_high_blue,average_blue_dominance)
  return(output)
}

# kita hitung semua biru yang ada
temp     = mclapply(bmkgs,birukan,mc.cores = ncore)
df_biru = data.table::rbindlist(temp) %>% as.data.frame()

# berikutnya kita rapikan namanya untuk jadi tanggal
df_biru = 
  df_biru %>% 
  separate(nama,into = c("bulan","tahun"),
           sep = "\\-") %>% 
  mutate(tanggal = 1) %>% 
  mutate(tgl = paste(tanggal,bulan,tahun,sep = "-"),
         tgl = as.Date(tgl,"%d-%m-%y")) %>% 
  select(-tanggal,-bulan,-tahun) %>% 
  arrange(tgl)

setwd("~/LearningForum/6 Warna BMKG")
save(df_biru,file = "data_biru.rda")
