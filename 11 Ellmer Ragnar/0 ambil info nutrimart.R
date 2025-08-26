rm(list=ls())  # Menghapus semua objek dari environment untuk memulai dengan workspace yang bersih

library(dplyr)    # Memuat package untuk manipulasi data (tidyverse)
library(rvest)    # Memuat package untuk web scraping

# ambil semua url
url = readLines("urls.txt")          # Membaca semua URL dari file teks ke dalam vector
url = url[!grepl("gift",url)]        # Menghapus URL yang mengandung kata "gift" (filtering)

# scrape informasi produk
ambilin = function(url){              # Mendefinisikan fungsi untuk scraping konten produk
  teks = 
    url |>                           # Menggunakan pipe operator untuk chaining
    read_html() |>                   # Membaca dan parsing HTML dari URL
    html_nodes("#accordion-content-description p") |>  # Menyeleksi elemen paragraf dalam div description
    html_text(trim = T)              # Mengekstrak teks dan menghapus whitespace di awal/akhir
  
  teks = gsub("\\\n",".",teks)       # Mengganti newline characters dengan titik
  teks = stringr::str_squish(teks)   # Menghapus whitespace berlebihan (multiple spaces/tabs)
  teks = paste(teks,collapse = "")   # Menggabungkan semua elemen teks menjadi satu string
  return(teks)                       # Mengembalikan teks hasil processing
}

info = vector("list",length(url))    # Membuat list kosong dengan panjang sesuai jumlah URL
for(i in 1:length(url)){             # Loop melalui setiap URL
  info[[i]] = ambilin(url[i])        # Menyimpan hasil scraping ke elemen list
  print(i)                           # Mencetak progress (indeks loop)
}

info                                # Menampilkan hasil scraping di console
save(info,file = "dbase_produk.rda") # Menyimpan hasil scraping ke file RData untuk penggunaan selanjutnya
