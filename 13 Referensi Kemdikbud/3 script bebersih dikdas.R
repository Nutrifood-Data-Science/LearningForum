rm(list=ls())
gc()

library(dplyr)
library(tidyr)

load("dikdas dengan digital ocean.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")
df_1   = df_all

load("dikdas ulang 935.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")
df_2   = df_all

load("dikdas ulang lagi 310.rda")

df_all = data.table::rbindlist(rumah_kita,fill = T) |> as.data.frame()
df_all = df_all |> distinct() |> janitor::clean_names() |> 
  filter(npsn != "1") |> 
  filter(npsn != "2") |> 
  filter(npsn != "No data available in table")
df_3   = df_all

df_all  = 
  bind_rows(df_1,df_2) |> 
  bind_rows(df_3) |> 
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

openxlsx::write.xlsx(df_all,file = "SD dan SMP ulang.xlsx")

library(janitor)
df_all |> 
  tabyl(prov) |> 
  arrange(desc(n))









