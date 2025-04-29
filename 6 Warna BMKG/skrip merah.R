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

# membuat functions untuk mengukur seberapa merah
merahkan = function(input){
  # Load the image
  img = readImage(input)
  
  # Get the dimensions of the image array
  img_dims = dim(img)
  
  # ambil red channel saja
  red_channel = img[,,1]
  
  # This gives a single value representing the overall redness
  average_red_intensity = mean(red_channel)
  
  # metric ini mengukur berapa banyak pixel yang berada di atas threshold merah
  red_threshold       = 0.8
  high_red_pixels     = sum(red_channel > red_threshold)
  total_pixels          = nrow(red_channel) * ncol(red_channel) # or length(red_channel)
  proportion_high_red = high_red_pixels / total_pixels
  
  # metric ini mengukur dominasi merah comapred to blue dan red 
  green_channel  = img[,,2]
  blue_channel = img[,,3]
  # Calculate per-pixel red dominance score (G - R + G - B) / 2
  # Values range from -1 (no red relative to others) to +1 (full red relative to others)
  red_dominance_per_pixel = ( (red_channel - green_channel) + (red_channel - blue_channel) ) / 2
  average_red_dominance   = mean(red_dominance_per_pixel)
  
  # membuat output
  output = data.frame(nama = gsub(".png","",input),
                      average_red_intensity,proportion_high_red,average_red_dominance)
  return(output)
}

# kita hitung semua merah yang ada
temp     = mclapply(bmkgs,merahkan,mc.cores = ncore)
df_merah = data.table::rbindlist(temp) %>% as.data.frame()

# berikutnya kita rapikan namanya untuk jadi tanggal
df_merah = 
  df_merah %>% 
  separate(nama,into = c("bulan","tahun"),
           sep = "\\-") %>% 
  mutate(tanggal = 1) %>% 
  mutate(tgl = paste(tanggal,bulan,tahun,sep = "-"),
         tgl = as.Date(tgl,"%d-%m-%y")) %>% 
  select(-tanggal,-bulan,-tahun) %>% 
  arrange(tgl)

setwd("~/LearningForum/6 Warna BMKG")
save(df_merah,file = "data_merah.rda")
