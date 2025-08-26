# Skrip Ellmer
rm(list=ls())
gc()

# libraries yang dibutuhkan
library(tidyverse)
library(stringr)
library(ellmer)

# reference
# https://ellmer.tidyverse.org/articles/ellmer.html

# pada kasus ini kita akan ambil deepseek dan openAI saja
Sys.setenv(DEEPSEEK_API_KEY="sk-24d2a5762f0841d0abcf39e018034d69")

# set sistem prompt di awal
prompt_sys = 
  str_squish("Kamu adalah expert dalam bahasa R dengan spesialisasi di Tidyverse untuk data manipulation dan caret untuk machine learning. Kamu juga seorang data scientist yang telah berpengalaman selama 20 tahun.")

# define chat
chat = chat_deepseek(system_prompt = prompt_sys)

# tanya langsung
tes_1 = chat$chat("jelaskan tentang clustering analysis secara singkat dalam 3 kalimat!",echo = "none")
tes_2 = chat$chat("jelaskan tentang clustering analysis secara singkat dalam 3 kalimat!",echo = "output")

# live chat di browser
live_browser(chat)

# live chat di console
live_console(chat)