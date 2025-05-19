# Clear all objects from the current workspace
rm(list = ls())

# Run garbage collection to free up memory
gc()

# Load required libraries
library(dplyr)
library(tidyr)
library(rvest)

# Set working directory for raw data
setwd("~/LearningForum/5 Mamikos/kota lain/raw")

# Prompt user to input city name through RStudio dialog
nama_kota = rstudioapi::showPrompt(title = "Nama Kota",
                                   message = "Tulis nama kota:")

# Create file path for saving the results
nama_file = paste0("~/LearningForum/5 Mamikos/kota lain/scraped/",
                   nama_kota,".rda")

# List all files in the directory
url = list.files(full.names = T)

# Read HTML content from the file
baca = url %>% read_html()

# Extract place names from HTML nodes and clean whitespace
nama_tempat = baca %>% html_nodes(".rc-info__name") %>% html_text() %>% stringr::str_trim()

# Extract area information from HTML nodes and clean whitespace
area        = baca %>% html_nodes(".bg-c-text--body-1") %>% html_text() %>% stringr::str_trim()

# Filter out areas containing discount/promo keywords
area        = area[!grepl("diskon|promo|cash|listrik|proma",area,ignore.case = T)]

# Create frequency table of areas
janitor::tabyl(area)

# Extract price information and clean to numeric format
harga       = baca %>% html_nodes(".rc-price__text") %>% html_text() %>% stringr::str_trim()
harga       = gsub("[^0-9]","",harga) %>% as.numeric()

# Extract facility information
fasilitas   = baca %>% html_nodes(".rc-facilities") %>% html_text()

# Create data frame with extracted data and process it
df_raw = 
  data.frame(nama_tempat,area,harga,fasilitas) %>% 
  mutate(area = gsub("kecamatan ","",area,ignore.case = T)) %>% 
  mutate(nama_cari = paste(area,nama_kota,"Indonesia",sep = ", "))

# Save the processed data to RData file
save(df_raw,file = nama_file)

# Delete the original HTML file
unlink(url)