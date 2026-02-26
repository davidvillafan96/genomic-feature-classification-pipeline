# ==============================================
# Functional Genomic Heatmap Pipeline
# Reproducible workflow for genomic feature profiling
# ==============================================

# Load required libraries
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(pheatmap)
library(tibble)

# ---- USER INPUT ----
# Folder containing *_interaccion.xlsx files
directorio <- "data"

# ---- FILE IMPORT ----
archivos <- list.files(
  path = directorio,
  pattern = "^[^~].*_interaccion\\.xlsx$",
  full.names = TRUE
)

datos_lista <- list()

for (archivo in archivos) {
  
  nombre_cepa <- str_extract(basename(archivo), "^[^_]+")
  
  df <- read_excel(archivo, col_names = TRUE) |> 
    select(Bloque = 3, Valor = 6) |> 
    filter(!is.na(Bloque), !is.na(Valor)) |> 
    mutate(Valor = suppressWarnings(as.numeric(Valor))) |> 
    group_by(Bloque) |> 
    summarise(Frecuencia = sum(Valor, na.rm = TRUE)) |> 
    mutate(Cepa = nombre_cepa)
  
  datos_lista[[nombre_cepa]] <- df
}

# ---- FEATURE MATRIX CREATION ----
df_todo <- bind_rows(datos_lista)

matriz <- df_todo |> 
  pivot_wider(
    names_from = Cepa,
    values_from = Frecuencia,
    values_fill = 0
  ) |> 
  column_to_rownames("Bloque") |> 
  as.matrix()

# ---- Z-SCORE NORMALIZATION ----
matriz_z <- t(scale(t(matriz)))
matriz_z[is.na(matriz_z)] <- 0

# ---- COLOR PALETTE ----
colores <- colorRampPalette(
  c("#1687E2", "#41b6c4", "#a1dab4", "#f5f85c", "#E1FC19")
)(100)

# ---- HEATMAP VISUALIZATION ----
pheatmap(
  matriz_z,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "complete",
  color = colores,
  border_color = NA,
  main = "Functional Genomic Frequency Heatmap",
  fontsize_row = 5,
  fontsize_col = 10
)

# ---- SAVE OUTPUT ----
dir.create("results", showWarnings = FALSE)

png(
  filename = "results/functional_genomic_heatmap.png",
  width = 2400,
  height = 3000,
  res = 300
)

pheatmap(
  matriz_z,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "complete",
  color = colores,
  border_color = NA,
  main = "Functional Genomic Frequency Heatmap",
  fontsize_row = 4,
  fontsize_col = 10
)

dev.off()

# ---- SAVE NORMALIZED MATRIX ----
write.csv(matriz_z, "results/functional_feature_matrix_zscore.csv")

# ---- SESSION INFO (for reproducibility) ----
sessionInfo()