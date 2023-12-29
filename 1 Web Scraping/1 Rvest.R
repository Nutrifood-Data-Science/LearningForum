# ============================================================================================================
# web scraping dengan teknik html parsing
# menggunakan library(rvest)
# sebagai contoh, kita akan ambil semua headline news dari situs detik.com
#
# ikanx101.com
# ============================================================================================================


# ============================================================================================================
# hapus environment
rm(list=ls())

# libraries
library(dplyr)
library(rvest)
# ============================================================================================================


# ============================================================================================================
# url awal
url = "https://www.detik.com/"

# ambil headline
headliner = 
  url %>% 
  read_html() %>% 
  html_nodes(".media__link") %>% 
  html_text(trim = T)
headliner = headliner[headliner != ""]

# buat nama file
nama_file = Sys.time() %>% as.character()
nama_file = paste0(nama_file,".csv")

# save headliner
write.csv(headliner,nama_file)

# done
# ============================================================================================================
