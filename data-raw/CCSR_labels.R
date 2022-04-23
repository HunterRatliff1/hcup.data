## code to prepare `CCSR_labels` dataset goes here


library(dplyr)
library(readr)
library(stringr)

CCSR_labs_dx <- readr::read_csv("data-raw/CCSR/CCSR_DX_categories.csv", col_types="cccc") %>%
  select(CCSR, CCSR_desc) %>%
  mutate(vers = "dx10")
CCSR_labs_pr <- readr::read_csv("data-raw/CCSR/CCSR_PR_categories.csv", col_types="ccccccc") %>%
  select(CCSR, CCSR_desc) %>%
  mutate(vers = "pr10")

CCSR_labels <- dplyr::bind_rows(CCSR_labs_dx, CCSR_labs_pr)

usethis::use_data(CCSR_labels, overwrite = TRUE)
