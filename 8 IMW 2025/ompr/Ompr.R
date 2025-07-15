rm(list=ls())
gc()

setwd("~/LearningForum/8 IMW 2025/ompr")

load("model_sr.rda")

library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

n_real = c(100,
           90,
           212,
           43,
           111,
           65,
           34,
           143,
           98,
           45,
           65,
           32)
# langsung pake ini

# menghitung srate dari model
input  = data.frame(total_in = n_real)
s_rate = predict(model,input) * 5


bin_prog = 
  MIPModel() %>%
  # menambah variabel
  # lane open
  add_variable(l[i],
               i = 1:12,
               type = "integer",
               lb = 1) %>%
  # passengers yang beneran masuk
  add_variable(n_total[i],
               i = 1:12,
               type = "integer",
               lb = 0) %>% 
  # processed passengers
  add_variable(pros[i],
               i = 1:12,
               type = "integer",
               lb = 0) %>%
  # unprocessed passengers
  add_variable(unpro[i],
               i = 1:12,
               type = "integer",
               lb = 0) %>%
  # n total pada saat i=1
  add_constraint(n_total[i] == n_real[i],
                 i = 1) %>%
  # max lane yang dibuka
  add_constraint(l[i] <= 17,
                 i = 1:12) %>% 
  # berapa banyak processed per i
  # kalau mau optimistik pakai <=
  # kalau mau cari aman pakai ==
  add_constraint(pros[i] <= l[i] * s_rate[i],
                 i = 1:12) %>% 
  # berapa yang unprocessed
  # pada i = 1
  add_constraint(unpro[i] == n_total[i] - pros[i],
                 i = 1) %>% 
  # n total pada 2 hingga 12
  add_constraint(n_total[i] == n_real[i] + unpro[i-1],
                 i = 2:12) %>% 
  # berapa yang unprocessed
  # pada i = 1
  add_constraint(unpro[i] == n_total[i] - pros[i],
                 i = 2:12) %>% 
  # objective function
  # obj func pertama
  # set_objective(sum_over(unpro[i],i = 1:12),
  #               "min") %>% 
  # obj func kedua
  set_objective(sum_over(unpro[i] + 12*l[i],i = 1:12),"min")

  
bin_prog 

hasil = 
  bin_prog %>%
  solve_model(with_ROI(solver = "glpk",
                       verbose = T))

hasil

lane = hasil %>% 
  get_solution(l[i]) %>% 
  pull(value)

n_total = 
  hasil %>% 
  get_solution(n_total[i]) %>% 
  pull(value)

processed = 
  hasil %>% 
  get_solution(pros[i]) %>% 
  pull(value)

unprocessed = 
  hasil %>% 
  get_solution(unpro[i]) %>% 
  pull(value)

output = 
  data.frame(n_real,n_total,s_rate,lane,
             processed,unprocessed)

output

save(output,file = "ompr_2.rda")








