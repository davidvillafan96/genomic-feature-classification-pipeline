# Genomic Feature Classification Pipeline

## Overview

This repository contains a reproducible analytical workflow for modeling functional genomic profiles across annotated microbial isolates.

The pipeline transforms annotation-derived functional data into structured feature matrices and applies normalization and hierarchical clustering to generate interpretable heatmaps for comparative genomic analysis and downstream statistical modeling.

Genomic annotations were retrieved from PLaBase (open-access platform) and processed into quantitative feature representations suitable for multivariate analysis.

---

## Methodological Framework

The workflow includes:

1. Batch import of annotation-derived interaction files  
2. Functional block aggregation and frequency summarization  
3. Construction of a genomic feature matrix (blocks × isolates)  
4. Row-wise Z-score normalization  
5. Unsupervised hierarchical clustering  
   - Distance metric: Euclidean  
   - Linkage method: Complete  
6. Heatmap visualization for functional pattern detection  

---

## Analytical Rationale

Biological systems can be encoded into structured feature spaces that enable statistical modeling and interpretable pattern recognition.

This framework supports:

- Functional landscape comparison across isolates  
- Detection of clustering patterns in high-dimensional genomic data  
- Feature engineering for downstream classification models  
- Data-driven strain prioritization strategies  

---

## Tools & Environment

- R  
- tidyverse (dplyr, tidyr, stringr)  
- readxl  
- pheatmap  

Session metadata is exported to ensure computational reproducibility.


---

## Output

The pipeline generates:

- High-resolution clustered heatmap (PNG)  
- Z-score normalized feature matrix (CSV)  
- Session information for reproducibility tracking  

---

## Reproducibility

All paths are project-relative to facilitate portability.  
The script includes session information to document package versions and runtime environment.

---

## Author

Developed as part of doctoral research in genomics, integrating computational feature engineering and multivariate modeling for functional genomic profiling.

---

## Project Structure
