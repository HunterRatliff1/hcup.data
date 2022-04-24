## code to prepare `valid_codes` dataset goes here

# This assumes you've already made all of the datasets
library(dplyr)
library(readr)


dx9 <- read_csv("data-raw/CCS/CCS_dx9_map.csv", col_types = "cccccc")[["I9_DX"]]
pr9 <- read_csv("data-raw/CCS/CCS_pr9_map.csv", col_types = "ccccc")[["I9_PR"]]
dx10 <- read_csv("data-raw/CCSR/CCSR_DX_mapping.csv", col_types = "cccccccccc")[["I10_DX"]]
pr10 <- read_csv("data-raw/CCSR/CCSR_PR_mapping.csv", col_types = "cccc")[["I10_PR"]]

valid_codes <- list(
  dx9  = dx9,
  pr9  = pr9,
  dx10 = dx10,
  pr10 = pr10
)



usethis::use_data(valid_codes, overwrite = TRUE)
