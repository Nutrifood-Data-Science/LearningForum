# ==============================================================================
# rm(list=ls())
# gc()

# libraries
library(dplyr)
library(rvest)
library(RSelenium)
library(tidyr)
# ==============================================================================

# ==============================================================================
# buka selenium session
ip_add        = "172.17.0.3"
remote_driver = remoteDriver(remoteServerAddr = ip_add, 
                             port = 4444L, 
                             browserName = "firefox")
remote_driver$open()
# ==============================================================================

# ==============================================================================
load("link_dikmen_kecamatan.rda")
urls = link_kecamatan_final[!grepl("all/all",link_kecamatan_final,fixed = T)]

input = urls[80]

input




# ini lah fungsinya
ekstraksi = function(input){
  # menuju url
  remote_driver$navigate(input)
  jeda = runif(1,1,1.3)
  Sys.sleep(jeda)

  # baca tabel dari pagination pertama
  # baca webnya
  baca   = remote_driver$getPageSource()[[1]] %>% read_html()
  
  # ambil tabel
  tabel = baca |> html_table(fill = T)
  tabel = tabel[[1]]
  
  # ini kita lanjutkan sampe selesai
  for(ikanx in 1:15){
    # mencari tombol next
    elemen = "#table1_next"
    lanjut <<- remote_driver$findElement("css", elemen)
    lanjut$clickElement()
    jeda = runif(1,1,1.2)
    Sys.sleep(jeda)
    
    # baca webnya
    baca   = remote_driver$getPageSource()[[1]] %>% read_html()
    
    # ambil tabel
    tempo = baca |> html_table(fill = T)
    tempo = tabel[[1]]
    
    # gabung
    tabel = rbind(tabel,tempo)
  }
  
  # yang kumau
  alamat = baca |> html_nodes(".breadcrumps") |> html_text()
  alamat = stringr::str_squish(alamat)
  output = tabel |> distinct() |> mutate(alamat)
  
  # output
  return(output)
}

# siapkan rumah
# rumah_kita = vector("list",length(urls))
for(ix in 109:length(urls)){
  temp = ekstraksi(urls[[ix]])
  Sys.sleep(1)
  rumah_kita[[ix]] = temp
  print(ix)
}

save(rumah_kita,file = "dikmen.rda")

