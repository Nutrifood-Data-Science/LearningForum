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
  jeda = runif(1,.1,.2)
  Sys.sleep(jeda)
  
  for(iterasi in 1:15){
    # baca webnya
    baca   = remote_driver$getPageSource()[[1]] %>% read_html()
    # ambil link nya
    links = 
      baca |> 
      html_nodes("a") |> 
      html_attr("href")
    links = links[grepl("/dikdas/",links,fixed = T)]
    
    # masukin ke rumah
    link_kota[[i]] = links
    i = i + 1
    cat(i)
    klik_donk_satt()
    Sys.sleep(.1)
  }
}

# sudah jadi link kota final
link_kota_final = link_kota |> unlist() |> unique()
save(link_kota_final,file = "link_dikdas_kota.rda")
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
<<<<<<< HEAD:13 Referensi Kemdikbud/1 scraper link dikdas.R
  jeda = runif(1,.3,.5)
=======
  jeda = runif(1,.1,.2)
>>>>>>> 02e92b9ea592b3d428e6cc55e6a2553906657ad0:13 Referensi Kemdikbud/1 scraper link.R
  Sys.sleep(jeda)
  
  
  for(iterasi in 1:15){
<<<<<<< HEAD:13 Referensi Kemdikbud/1 scraper link dikdas.R
=======
    # baca webnya
    baca   = remote_driver$getPageSource()[[1]] %>% read_html()
>>>>>>> 02e92b9ea592b3d428e6cc55e6a2553906657ad0:13 Referensi Kemdikbud/1 scraper link.R
    # ambil link nya
    links = 
      baca |> 
      html_nodes("a") |> 
      html_attr("href")
    links = links[grepl("/dikdas/",links,fixed = T)]
    
    # masukin ke rumah
    link_kecamatan[[i]] = links
    i = i + 1
    cat(i)
<<<<<<< HEAD:13 Referensi Kemdikbud/1 scraper link dikdas.R
    klik_donk_satt()
    Sys.sleep(.2)
  }
  
=======
    
    klik_donk_satt()
    Sys.sleep(.05)
  }
>>>>>>> 02e92b9ea592b3d428e6cc55e6a2553906657ad0:13 Referensi Kemdikbud/1 scraper link.R
}

# sudah jadi link kota final
link_kecamatan_final = link_kecamatan |> unlist() |> unique()

save(link_kecamatan_final,link_kota_final,file = "link_dikdas_kecamatan.rda")
<<<<<<< HEAD:13 Referensi Kemdikbud/1 scraper link dikdas.R
# ==============================================================================
=======
# ==============================================================================
>>>>>>> 02e92b9ea592b3d428e6cc55e6a2553906657ad0:13 Referensi Kemdikbud/1 scraper link.R
