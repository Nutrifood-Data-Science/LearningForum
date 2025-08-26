rm(list=ls())
gc()

# Load necessary libraries
library(reticulate)
library(readr)
library(dplyr)

# Load Python libraries in R
transformers <- reticulate::import("sentence_transformers")

# Load pre-trained sentence transformer model
model <- transformers$SentenceTransformer('firqaaa/indo-sentence-bert-base')

# ambil data komplen
load("dbase_produk.rda")
info = info |> unlist()

# melakukan embedding
complaint_embeddings <- model$encode(info)

# bikin matriks embedding
embeddings_matrix <- as.matrix(reticulate::py_to_r(complaint_embeddings))

# Menentukan rentang jumlah cluster yang akan diuji dan menghitung rata-rata silhouette
k_range <- 2:10

library(factoextra)
library(cluster)

avg_sil_widths <- sapply(k_range, function(k) {
  # Melakukan clustering k-means dan menghitung silhouette score untuk setiap nilai k
  kmeans_result <- kmeans(embeddings_matrix, centers = k,iter.max = 50)
  sil <- silhouette(kmeans_result$cluster, dist(embeddings_matrix))
  mean(sil[, 3])
})

# Menentukan jumlah cluster optimal berdasarkan nilai silhouette tertinggi
optimal_k <- k_range[which.max(avg_sil_widths)]

# Melakukan clustering k-means dengan jumlah cluster optimal
kmeans_result <- kmeans(embeddings_matrix, centers = optimal_k,iter.max = 50)

# Membuat data frame hasil clustering
hasil = data.frame(text = info,cluster = kmeans_result$cluster)

# Menggabungkan komentar dalam setiap cluster
final =
  hasil |> 
  group_by(cluster) |> 
  summarise(komen = paste(text,collapse = ".")) |> 
  ungroup()
