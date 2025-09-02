rm(list=ls())
gc()

library(tidyr)
library(dplyr)
library(rvest)

# smp dan sma
url = "https://referensi.data.kemendikdasmen.go.id/pendidikan/dikmen"

links = 
  url |> 
  read_html() |> 
  html_nodes("a") |> 
  html_attr("href")
