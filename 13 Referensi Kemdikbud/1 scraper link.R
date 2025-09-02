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
link_kota = vector("list",length(urls))
i = 1

# kita mulai buka dan ambil
for(url in urls){
  print(url)
  remote_driver$navigate(url)
  jeda = runif(1,1,3)
  Sys.sleep(jeda)
  
  # baca webnya
  baca   = remote_driver$getPageSource()[[1]] %>% read_html()
  
  # ambil link nya
  links = 
    baca |> 
    html_nodes("a") |> 
    html_attr("href")
  links = links[grepl("/dikmen/",links,fixed = T)]
  
  # masukin ke rumah
  link_kota[[i]] = links
  i = i + 1
  print(i)
  }

# sudah jadi link kota final
link_kota_final = link_kota |> unlist() |> unique()
# ==============================================================================

# ==============================================================================
# sekarang kita loop untuk dapat kecamatan
# siapin rumahnya
link_kecamatan = vector("list",length(link_kota_final))
i = 1

# kita mulai buka dan ambil
for(url in link_kota_final){
  print(url)
  remote_driver$navigate(url)
  jeda = runif(1,1,3)
  Sys.sleep(jeda)
  
  # baca webnya
  baca   = remote_driver$getPageSource()[[1]] %>% read_html()
  
  # ambil link nya
  links = 
    baca |> 
    html_nodes("a") |> 
    html_attr("href")
  links = links[grepl("/dikmen/",links,fixed = T)]
  
  # masukin ke rumah
  link_kecamatan[[i]] = links
  i = i + 1
  print(i)
}

# sudah jadi link kota final
link_kecamatan_final = link_kecamatan |> unlist() |> unique()

save(link_kecamatan_final,link_kota_final,file = "links.rda")
# ==============================================================================