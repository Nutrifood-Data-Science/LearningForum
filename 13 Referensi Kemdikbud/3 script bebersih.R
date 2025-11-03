rm(list=ls())
gc()

library(dplyr)
library(tidyr)

load("dikmen ulang.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")
df_1   = df_all

load("dikmen ulang.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")
df_2   = df_all

load("dikmen ulang.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")
df_3   = df_all

df_all  = 
  rbind(df_1,df_2) |> 
  rbind(df_3) |> 
  distinct() |> 
  separate(alamat_2,
           into = c("negara","prov","kota_kab","kecamatan"),
           sep = ">>"
           ) |> 
  mutate(negara    = stringr::str_squish(negara),
         prov      = stringr::str_squish(prov),
         kota_kab  = stringr::str_squish(kota_kab),
         kecamatan = stringr::str_squish(kecamatan)
         ) |> 
  arrange(prov,kota_kab,kecamatan)

openxlsx::write.xlsx(df_all,file = "SMA ulang.xlsx")

library(janitor)
df_all |> 
  tabyl(prov) |> 
  arrange(n)










