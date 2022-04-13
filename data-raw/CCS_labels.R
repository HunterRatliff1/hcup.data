## code to prepare `CCS_labels` dataset goes here
# This combines the various CCS labels into one file

# Should be noted that the categories are consistent across ICD-9 and ICD-10
# (after applying the changes in syntax that I made), but the text descriptions
# do differ slightly. The ICD-10 version provides more details, so I use that version
# where possible
library(dplyr)
library(readr)
library(stringr)

CCS_dx9_label  <- readr::read_csv("data-raw/CCS/CCS_dx9_label.csv", col_types="ccc")
CCS_pr9_label  <- readr::read_csv("data-raw/CCS/CCS_pr9_label.csv", col_types="ccc")
CCS_dx10_label <- read_csv("data-raw/CCS/CCS_dx10_label.csv", col_types = "ccc")
CCS_pr10_label <- read_csv("data-raw/CCS/CCS_pr10_label.csv", col_types = "ccc")


CCS_dx <- left_join(CCS_dx9_label, CCS_dx10_label,
                    by=c("CCS", "CCS_Level"),
                    suffix = c(".9", ".10")) %>%
  mutate(CCS_label = ifelse(is.na(CCS_label.10), CCS_label.9, CCS_label.10)) %>%
  select(CCS, CCS_label, CCS_Level)

CCS_pr <- left_join(CCS_pr9_label, CCS_pr10_label,
          by=c("CCS", "CCS_Level"),
          suffix = c(".9", ".10")) %>%
  mutate(CCS_label = ifelse(is.na(CCS_label.10), CCS_label.9, CCS_label.10)) %>%
  select(CCS, CCS_label, CCS_Level)


CCS_labels <- bind_rows(CCS_dx, CCS_pr) %>% unique()

usethis::use_data(CCS_labels, overwrite = TRUE)
