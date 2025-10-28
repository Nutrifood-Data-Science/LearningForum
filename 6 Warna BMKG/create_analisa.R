library(tidyverse)
library(broom)

# Fungsi untuk melakukan uji Wilcoxon dan menghasilkan label signifikansi
perform_pairwise_wilcox_test <- function(df, year_col, value_col) {
  years <- unique(df[[year_col]])
  year_pairs <- combn(years, 2, simplify = FALSE)
  
  results <- map_df(year_pairs, function(pair) {
    year1 <- pair[1]
    year2 <- pair[2]
    
    data1 <- df %>% filter(!!sym(year_col) == year1) %>% pull(!!sym(value_col))
    data2 <- df %>% filter(!!sym(year_col) == year2) %>% pull(!!sym(value_col))
    
    # Uji Wilcoxon
    wilcox_result <- tryCatch({
      wilcox.test(data1, data2, exact = FALSE)
    }, error = function(e) {
      return(NULL)
    })
    
    if (!is.null(wilcox_result)) {
      p_value <- wilcox_result$p.value
      significance <- ifelse(p_value < 0.05, "sig", "no sig")
    } else {
      significance <- "error"
    }
    
    tibble(
      year1 = year1,
      year2 = year2,
      significance = significance
    )
  })
  
  return(results)
}

# Fungsi utama untuk membuat matriks perbandingan
create_wilcox_comparison_matrix <- function(df, year_col = "tahun", value_col = "average_green_intensity") {
  # Pastikan kolom tahun ada
  if (!year_col %in% names(df)) {
    stop("Kolom tahun tidak ditemukan dalam dataframe")
  }
  
  # Pastikan kolom nilai ada
  if (!value_col %in% names(df)) {
    stop("Kolom nilai tidak ditemukan dalam dataframe")
  }
  
  # Dapatkan hasil uji pairwise Wilcoxon
  pairwise_results <- perform_pairwise_wilcox_test(df, year_col, value_col)
  
  # Buat matriks kosong
  years <- sort(unique(df[[year_col]]))
  n_years <- length(years)
  
  # Inisialisasi matriks dengan NA
  comparison_matrix <- matrix(NA, nrow = n_years, ncol = n_years)
  rownames(comparison_matrix) <- years
  colnames(comparison_matrix) <- years
  
  # Isi diagonal dengan string kosong
  diag(comparison_matrix) <- ""
  
  # Isi matriks dengan hasil signifikansi
  for (i in 1:nrow(pairwise_results)) {
    year1 <- pairwise_results$year1[i]
    year2 <- pairwise_results$year2[i]
    sig <- pairwise_results$significance[i]
    
    row_idx <- which(rownames(comparison_matrix) == year1)
    col_idx <- which(colnames(comparison_matrix) == year2)
    
    comparison_matrix[row_idx, col_idx] <- sig
    comparison_matrix[col_idx, row_idx] <- sig  # Simetris
  }
  
  # Konversi ke dataframe untuk output yang lebih rapi
  comparison_df <- as.data.frame(comparison_matrix)
  comparison_df <- cbind(Year = rownames(comparison_df), comparison_df)
  rownames(comparison_df) <- NULL
  
  return(comparison_df)
}


# Visualisasi matriks (opsional)
create_wilcox_heatmap <- function(comparison_df) {
  library(ggplot2)
  library(reshape2)
  
  # Hilangkan kolom pertama (Year) untuk melting
  plot_data <- comparison_df[, -1]
  rownames(plot_data) <- comparison_df$Year
  colnames(plot_data)[1] <- comparison_df$Year[1]  # Sesuaikan nama kolom pertama
  
  melted_data <- plot_data %>%
    as.matrix() %>%
    melt() %>%
    mutate(
      Var1 = factor(Var1, levels = unique(Var1)),
      Var2 = factor(Var2, levels = unique(Var2))
    ) %>%
    filter(!is.na(value))
  
  ggplot(melted_data, aes(x = Var2, y = Var1, fill = value)) +
    geom_tile(color = "white", linewidth = 1) +
    geom_text(aes(label = value), color = "black", size = 3) +
    scale_fill_manual(values = c("sig" = "#ff6b6b", "no sig" = "#51cf66", "error" = "gray"), 
                      na.value = "white") +
    theme_minimal() +
    labs(title = "Matriks Perbandingan Signifikansi (Uji Wilcoxon)",
         x = "Tahun", y = "Tahun",
         subtitle = "sig = p-value < 0.05, no sig = p-value ≥ 0.05",
         caption = "Catatan: Perhitungan rata-rata data bulanan.") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          panel.grid = element_blank(),
          legend.position = "none")
}






