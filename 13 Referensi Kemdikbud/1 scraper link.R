# ==============================================================================
rm(list=ls())
gc()

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
# smp dan sma
# link provinsi
urls = readLines("link provinsi.txt")

# siapin rumahnya
link_kota = vector("list")

# ini function untuk next
klik_donk_satt = function(){
  elemen = "#table1_next"
  next_  = remote_driver$findElement("css", elemen)
  next_$clickElement()
}

i=1
# kita mulai buka dan ambil
for(url in urls){
  print(url)
  remote_driver$navigate(url)
  jeda = runif(1,.4,.7)
  Sys.sleep(jeda)
  
  # baca webnya
  baca   = remote_driver$getPageSource()[[1]] %>% read_html()
  
  for(iterasi in 1:15){
    # ambil link nya
    links = 
      baca |> 
      html_nodes("a") |> 
      html_attr("href")
    links = links[grepl("/dikmen/",links,fixed = T)]
    
    # masukin ke rumah
    link_kota[[i]] = links
    i = i + 1
    
    klik_donk_satt()
    Sys.sleep(.1)
  }
  cat(i)
  }

# sudah jadi link kota final
link_kota_final = link_kota |> unlist() |> unique()
save(link_kota_final,file = "link_dikmen_kota.rda")
# ==============================================================================

# ==============================================================================
# sekarang kita loop untuk dapat kecamatan
# siapin rumahnya
link_kecamatan = vector("list")
i = 1

# kita mulai buka dan ambil
for(url in link_kota_final){
  print(url)
  remote_driver$navigate(url)
  jeda = runif(1,1,1.3)
  Sys.sleep(jeda)
  
  # baca webnya
  baca   = remote_driver$getPageSource()[[1]] %>% read_html()
  
  for(iterasi in 1:10){
    # ambil link nya
    links = 
      baca |> 
      html_nodes("a") |> 
      html_attr("href")
    links = links[grepl("/dikmen/",links,fixed = T)]
    
    # masukin ke rumah
    link_kecamatan[[i]] = links
    i = i + 1
    
    klik_donk_satt()
    Sys.sleep(1)
  }
  
  print(i)
}

# sudah jadi link kota final
link_kecamatan_final = link_kecamatan |> unlist() |> unique()

save(link_kecamatan_final,link_kota_final,file = "link_dikmen_kecamatan.rda")
# ==============================================================================