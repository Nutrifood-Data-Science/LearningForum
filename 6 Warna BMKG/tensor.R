# rm(list=ls())
# gc()

library(dplyr)
library(caret)
library(tensorflow)
library(keras3)
library(readxl)
library(scales)

setwd("~/LearningForum/6 Warna BMKG")

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
  select(-tgl) %>% 
  mutate(so = rescale(so))

# kita pisahkan
# target
target = df_input %>% pull(so) %>% as.matrix()
# input
input  = df_input %>% select(-so) %>% as.matrix()

# kita mulai bikin modelnya ya
model = keras_model_sequential()

model %>%
  # Adds a densely-connected layer with 64 units to the model:
  layer_dense(units = 21, activation = 'gelu', 
              input_shape = ncol(input)) %>%
  # Add another:
  layer_dense(units = 12, activation = 'gelu') %>%
  layer_dense(units = 19, activation = 'tanh') %>%
  layer_dense(units = 86, activation = 'gelu') %>%
  layer_dense(units = 12, activation = 'gelu') %>%
  layer_dense(units = 2, activation = 'swish') %>%
  layer_dense(units = 1, activation = 'sigmoid')

# optimizer
model %>% compile(
  loss = "mse",
  optimizer =  "adam",
  metrics = list(metric_r2_score()) # Add R2Score as a metric
  # metrics = list("mean_absolute_error")
)

model %>% summary()

model %>% fit(input,target, 
              epochs = 3000,
              validation_split = 0.3,
              batch_size = 45)

scores = model %>% evaluate(input, 
                            target, verbose = 0)
print(scores)

# r2 hasil training 0.7538

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
  geom_point(group = 1,color = "blue") 
  # geom_smooth(method = "loess") 
  # xlim(10,28) +
  # ylim(10,28) +


df_hasil %>% 
  mutate(error = abs(y_deep - y)) %>% 
  summarise(mean(error),
            median(error))

setwd("~/LearningForum/6 Warna BMKG/saved_model/model_1")
keras3::save_model(model,"model.keras")

model = keras3::load_model("model.keras")

library(DALEX)

explainer_mmm = DALEX::explain(model = model,
                               data  = input,
                               y     = target,
                               type  = "regression",
                               label = "Regression BMKG",
                               colorize = FALSE)

performa_model = model_performance(explainer_mmm)
performa_model

var_importante  = model_parts(explainer_mmm)
plot_importance = plot(var_importante,show_boxplots = FALSE)
plot_importance

mp_mmm = model_profile(explainer_mmm, 
                       variable =  c("average_green_dominance",
                                     "average_red_dominance"), 
                       type = "accumulated")
plot(mp_mmm)


max_so = 
  df_input %>% 
  filter(so == max(so)) %>% 
  select(-so) %>% 
  as.matrix()
max_plot = predict_parts(explainer_mmm, max_so)
plot(max_plot)

min_so = 
  df_input %>% 
  filter(so == min(so)) %>% 
  select(-so) %>% 
  as.matrix()
min_plot = predict_parts(explainer_mmm, min_so)
plot(min_plot)

setwd("~/LearningForum/6 Warna BMKG")
save(input,
     target,
     df_input,
     explainer_mmm,
     performa_model,
     var_importante,plot_importance,mp_mmm,
     max_so,max_plot,
     min_so,min_plot,
     file = "hasil_keras.rda")
