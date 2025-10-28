rm(list=ls())
gc()

library(dplyr)
library(caret)
library(tensorflow)
library(keras3)
library(readxl)
library(scales)

# kita ambil selling out
file = "data so ns polos_281025.xlsx"
df   = read_excel(file,sheet = "Data",skip = 3) %>% janitor::clean_names()

# kita rapikan data selling outnya
df_so = 
  df %>% 
  rename(tahun = year_of_invoice_date_so,
         bulan = month_of_invoice_date_so,
         so    = net_sell_out) %>% 
  mutate(tgl = paste("1",bulan,tahun),
         tgl = as.Date(tgl,"%d %B %Y")) %>% 
  select(tgl,so)

# load data warna-warna
load("data_hijau.rda")
load("data_merah.rda")
load("data_biru.rda")

# **Penjelasan:**
#   
# 1. **Min-Max Scaling (0-1 range):**
#   - Menggunakan `rescale()` dari package `scales`
#   - Rumus: `(x - min(x)) / (max(x) - min(x))`
#   - Cocok untuk algoritma yang sensitif terhadap skala seperti SVM, KNN
# 
# 2. **Standard Scaling (Z-score):**
#   - Menggunakan `scale()` dari base R
#   - Rumus: `(x - mean(x)) / sd(x)`
#   - Cocok untuk algoritma yang mengasumsikan distribusi normal

# kita gabung
df_input = 
  merge(df_so,df_biru,all.x = T) %>% 
  merge(df_hijau) %>% 
  merge(df_merah) %>% 
  select(-tgl) 
  # mutate(so = scale(so))

# kita pisahkan
# target
target = df_input %>% pull(so) %>% as.matrix()
# input
input  = df_input %>% select(-so) %>% as.matrix()

# kita mulai bikin modelnya ya
model = keras_model_sequential()

model %>%
  # Adds a densely-connected layer with 64 units to the model:
  layer_dense(units = 30, activation = 'sigmoid', 
              input_shape = ncol(input)) %>%
  # Add another:
  layer_dense(units = 30, activation = 'sigmoid') %>%
  layer_dense(units = 30, activation = 'relu') %>%
  layer_dense(units = 30, activation = 'sigmoid') %>%
  layer_dense(units = 1, activation = 'relu')

# optimizer
model %>% compile(
  loss = "mse",
  optimizer =  "adam",
  metrics = list("mean_absolute_error")
)

model %>% summary()

model %>% fit(input,target, 
              epochs = 500,
              validation_split = 0.3,
              batch_size = 30)

scores = model %>% evaluate(input, 
                            target, verbose = 0)
print(scores)


# kita buat prediksinya
y_deep = model %>% predict(input)
y_deep
target

# menggabungkan hasil deep learning ke df_hasil
df_hasil    = data.frame(y = target,y_deep = y_deep)

# membuat plot y = f(x)
df_hasil |>
  ggplot(aes(x = y,y = y_deep)) +
  # plot awal fungsi dari soal
  geom_point(group = 1,color = "blue") +
  geom_smooth(method = "loess") +
  # xlim(10,28) +
  # ylim(10,28) +
  coord_equal()








