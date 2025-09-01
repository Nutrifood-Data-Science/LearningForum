rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(rvest)

setwd("~/LearningForum/12 Dapodik/html kota")

url = list.files(full.names = T)

ambil_link = function(url){
  link = 
    url |> 
    read_html() |> 
    html_nodes("a") |> 
    html_attr("href")
  
  link = link[grepl("sp/3",link)]
  link = stringr::str_trim(link)
  link = paste0("https://dapo.kemendikdasmen.go.id",link)
  
  link = paste0("'",link,"'")
  link = paste(link,collapse = ",")
  
  return(link)
}

link_all = sapply(url, ambil_link)
link_all = paste(link_all,collapse = ",")

sink("tes.txt")
cat(link_all)
sink()