rm(list=ls())
gc()

library(ragnar)
library(ellmer)
library(rvest)
library(dplyr)
library(stringr)

# ambil semua url
url = readLines("urls.txt")          
url = url[!grepl("gift",url)]  