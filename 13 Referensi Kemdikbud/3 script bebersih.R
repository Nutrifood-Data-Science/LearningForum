rm(list=ls())
gc()

library(dplyr)
library(tidyr)

load("dikdas.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")

df_all |> janitor::tabyl(npsn) |> arrange(desc(n)) |> head(20)

df_all |> pull(alamat_2) |> head(2)

df_all  = 
  df_all |> 
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

openxlsx::write.xlsx(df_all,file = "SD dan SMP.xlsx")