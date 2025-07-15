rm(list=ls())
gc()

set.seed(10104074)

library(dplyr)
library(reticulate)
library(keras3)
library(tensorflow)
library(caret)

load("draft/data.rda")

# kita persiapkan terlebih dahulu
qleng = df$queue_time

# saya bikin 6 bulan untuk prediksi 1 bulan
n_bulan = 10
n_data  = nrow(df)
n_ding  = n_data - n_bulan

# membuat data input untuk training
input = data.frame(x1 = 0,
                   x2 = 0,
                   x3 = 0,
                   x4 = 0,
                   x5 = 0,
                   x6 = 0,
                   x7 = 0,
                   x8 = 0,
                   x9 = 0,
                   x10 = 0)
target = rep(0,n_ding)

# mulai iterasi untuk membuat data training
for(i in 1:n_ding){
  save      = qleng[i:(i + n_bulan - 1)] %>% t() %>% list()
  input[i,] = save[[1]]
  target[i] = qleng[i + n_bulan]
}

# berikut adalah tampilan hasilnya
head(input,5)

input_asli = input


# function untuk random noise
acak = function(n){
  n + runif(1,min = -3,max = 3)
  floor(n)
}

# berapa banyak upsampling yang akan dilakukan
n_aug = 200

# ambil id acak untuk upsampling
id_acak = sample(nrow(input),
                 n_aug,
                 replace = T) %>% sort()

# augment input
input_2  =
  input %>% 
  mutate_all(acak)

# augment target
target_2 = sapply(target,acak)

# saya ambil yang acak id saja
input_2  = input_2[id_acak,]
target_2 = target_2[id_acak]

# gabung all untuk training
input    = rbind(input,input_2)
target   = c(target,target_2)

# kita jadikan input
x = input %>% as.matrix()
y = target %>% as.matrix()

# kita bangun model dari awal
model = 
  keras_model_sequential() %>% 
  layer_lstm(units  = 300, activation = "linear", input_shape = c(ncol(x),1)) %>% 
  layer_dense(units = 150,   activation = "linear") %>%
  layer_dense(units = 1,   activation = "linear") %>%
  layer_activation("linear")

# compiler
model %>% compile(
  loss      = "mse",
  optimizer = "adam", 
  metrics   = list("mean_absolute_error")
)

# fit model
# fitmodel = 
  model %>% fit(x,y,
                epochs  = 50,
                verbose = 0,
                validation_split = 0.15,
                batch_size = 30)

# kita plot dulu
# plot(fitmodel)

# kita save dulu 
keras3::save_model(model,filepath = "model_dl_5.keras",
                   overwrite = T)

input_pred = input_asli[1,]

# kita mulai iterasinya
scores = model %>% evaluate(x,y, 
                            verbose = 0)
print(scores)

simpan = rep(NA,201)

# kita buat prediksinya
for(ikanx in 2:201){
  input_x = as.matrix(input_pred)
  
  y_deep  = model %>% predict(input_x)
  y_deep = as.numeric(y_deep)
  
  simpan[ikanx-1] = y_deep
  
  lanjut = input_pred[2:10] %>% as.numeric()
  lanjut = c(lanjut,y_deep)
  
  input_pred = lanjut %>% t()
}

qleng_asli = df$queue_time[1:200]

data.frame(id = 1:201,
           qtime = simpan) %>% 
  filter(!is.na(qtime)) %>%
  mutate(qtime_asli = qleng_asli) %>% 
  ggplot() +
  geom_line(aes(x = id,
                y = qtime),
            group = 1,color = "darkred") +
  geom_line(aes(x = id,
                y = qtime_asli),
            group = 1,color = "blue")
  

simpan









