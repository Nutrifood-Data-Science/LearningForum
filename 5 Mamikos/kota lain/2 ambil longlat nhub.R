# Membersihkan lingkungan kerja dengan menghapus semua objek yang ada
rm(list=ls())

# Menjalankan garbage collection untuk mengosongkan memori
gc()

# Memuat paket-paket yang diperlukan untuk manipulasi data
library(dplyr)
library(tidyr)
library(readxl)

# Menentukan path file Excel yang akan dibaca
file = "~/LearningForum/5 Mamikos/kota lain/dbase nhub/dbase nhub.xlsx"

# Membaca file Excel dan membersihkan nama kolom menggunakan janitor
df_nhub = read_excel(file) %>% janitor::clean_names()

# Menyimpan data frame yang sudah dibersihkan ke dalam file rda
save(df_nhub,file = "~/LearningForum/5 Mamikos/kota lain/clean/nhub.rda")