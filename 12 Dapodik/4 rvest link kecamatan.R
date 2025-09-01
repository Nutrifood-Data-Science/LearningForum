rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(rvest)
library(parallel)

ncore = detectCores()

setwd("~/LearningForum/12 Dapodik/html kecamatan")

# kita filter dulu
url = list.files(full.names = T)
url = url[grepl("sp_3",url,fixed = T)]

buatkan_data = function(input){
  tabel = 
    input |> 
    read_html() |> 
    html_table(fill = T)
  
  if(length(tabel) == 0){output = data.frame()}
  if(length(tabel) > 0){
    tabel = tabel[[1]] |> janitor::clean_names()
    
    kecamatan = 
      input |> 
      read_html() |> 
      html_nodes(".breadcrumb .active") |> 
      html_text()
    kecamatan = ifelse(length(kecamatan) == 0,NA,kecamatan)
        
    kab_kota = 
      input |> 
      read_html() |> 
      html_nodes(".breadcrumb li:nth-child(4) a") |> 
      html_text()
    kab_kota = ifelse(length(kab_kota) == 0,NA,kab_kota)
    
    provinsi = 
      input |> 
      read_html() |> 
      html_nodes(".breadcrumb li:nth-child(3) a") |> 
      html_text()
    provinsi = ifelse(length(provinsi) == 0,NA,provinsi)
    
    output = 
      tabel |> 
      mutate(provinsi,kab_kota,kecamatan)
  }

  return(output)
}

hasil = vector("list",7704)
for(i in 1:7704){
  hasil[[i]] = buatkan_data(url[i])
  print(i)
}

final = data.table::rbindlist(hasil,fill = T) |> as.data.frame()
final = final |> distinct() |> arrange(provinsi,kab_kota,kecamatan)
final = final |> filter(!grepl("total",no,ignore.case = T)) |> select(-no)

setwd("~/LearningForum/12 Dapodik")
openxlsx::write.xlsx(final,file = "Sekolah Dapodik.xlsx")




