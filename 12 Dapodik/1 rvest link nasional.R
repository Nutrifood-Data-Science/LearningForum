rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(rvest)

url = "dapo.kemendikdasmen.go.id_sp_20250828042157849.html"

link = 
  url |> 
  read_html() |> 
  html_nodes("a") |> 
  html_attr("href")

link = link[grepl("sp/1",link)]
link = stringr::str_trim(link)
link = paste0("https://dapo.kemendikdasmen.go.id",link)

link = paste0("'",link,"'")
link = paste(link,collapse = ",")
