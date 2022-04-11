## code to prepare `CCS_icd10` dataset goes here

# Referance URL: https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/ccsr_archive.jsp
library(dplyr)
library(tidyr)
# library(purrr)
library(stringr)
library(readr)
library(usethis)

#### READ FILES ####
## Beta Version of the CCS for ICD-10-CM (v2019.1, beta)
data_url_dx <- "https://www.hcup-us.ahrq.gov/toolssoftware/ccs10/ccs_dx_icd10cm_2019_1.zip"

## Beta Version of the CCS for ICD-10-PCS (v2020.1, beta)
data_url_pr <- "https://www.hcup-us.ahrq.gov/toolssoftware/ccs10/ccs_pr_icd10pcs_2020_1.zip"

# Read the zip file and extract files
d <- tempdir()

# Read the files
archive::archive_extract(data_url_dx,
                         dir  = d,
                         files = c("ccs_dx_icd10cm_2019_1.csv"))
archive::archive_extract(data_url_pr,
                         dir  = d,
                         files = c("ccs_pr_icd10pcs_2020_1.csv"))



#### FORMAT DF's ####
df_i10_dx <- readr::read_csv(file = glue::glue("{d}/ccs_dx_icd10cm_2019_1.csv"), skip = 1,
                             col_types = "cccccccc",
                             col_names = c("I10_DX", "CCS", "I10_DX_desc", "CCS_desc",
                                           "CCS_lvl1_code", "CCS_lvl1_desc",
                                           "CCS_lvl2_code", "CCS_lvl2_desc")) %>%
  mutate(across(everything(), str_remove_all, "\\'"),
         across(everything(), str_trim),
         across(everything(), na_if, ""),
         CCS = paste0("DX", CCS),
         across(c(CCS_lvl1_code, CCS_lvl2_code), ~ifelse(!is.na(.x), paste0("DX-", .x), .x)))



df_i10_pr <- readr::read_csv(file = glue::glue("{d}/ccs_pr_icd10pcs_2020_1.csv"), skip = 1,
                             col_types = "cccccccc",
                             col_names = c("I10_PR", "CCS", "I10_PR_desc", "CCS_desc",
                                           "CCS_lvl1_code", "CCS_lvl1_desc",
                                           "CCS_lvl2_code", "CCS_lvl2_desc")) %>%
  mutate(across(everything(), str_remove_all, "\\'"),
         across(everything(), str_trim),
         across(everything(), na_if, ""),
         CCS = paste0("PR", CCS),
         across(c(CCS_lvl1_code, CCS_lvl2_code), ~ifelse(!is.na(.x), paste0("PR-", .x), .x)))


#### SEPERATE LABELS ####
####    ~ icd10 dx   ####
CCS_dx10_map <- df_i10_dx %>%
  select(-ends_with("_desc")) %>%
  rename_with(~str_remove(.x, "_code"))



# Take all of the descriptions and make a tidy df
# with thier CCS categories
CCS_dx10_label <- df_i10_dx %>%
  rename(CCS_main_code=CCS, CCS_main_desc=CCS_desc) %>%
  select(-I10_DX, -I10_DX_desc) %>%
  pivot_longer(everything(),
               names_to      = c("level", ".value"),
               names_pattern = "CCS_(....)_(....)") %>%
  select(CCS=code, CCS_label=desc, CCS_Level=level) %>%
  filter(!is.na(CCS)) %>%
  unique()

####    ~ icd10 pr   ####
CCS_pr10_map <- df_i10_pr %>%
  select(-ends_with("_desc")) %>%
  rename_with(~str_remove(.x, "_code"))

# Take all of the descriptions and make a tidy df
# with thier CCS categories
CCS_pr10_label <- df_i10_pr %>%
  rename(CCS_main_code=CCS, CCS_main_desc=CCS_desc) %>%
  select(-I10_PR, -I10_PR_desc) %>%
  pivot_longer(everything(),
               names_to      = c("level", ".value"),
               names_pattern = "CCS_(....)_(....)") %>%
  select(CCS=code, CCS_label=desc, CCS_Level=level) %>%
  filter(!is.na(CCS)) %>%
  unique()



####   WRITE TO FILE   ####
####  ~ Write to CSV   ####
readr::write_csv(CCS_dx10_map,   "data-raw/CCS/CCS_dx10_map.csv")
readr::write_csv(CCS_dx10_label, "data-raw/CCS/CCS_dx10_label.csv")
readr::write_csv(CCS_pr10_map,   "data-raw/CCS/CCS_pr10_map.csv")
readr::write_csv(CCS_pr10_label, "data-raw/CCS/CCS_pr10_label.csv")

rm(CCS_dx10_map, CCS_dx10_label, df_i10_dx,
   CCS_pr10_map, CCS_pr10_label, df_i10_pr)

#### ~ Write to object ####
CCS_dx10_map   <- read_csv("data-raw/CCS/CCS_dx10_map.csv", col_types = "cccc")
CCS_dx10_label <- read_csv("data-raw/CCS/CCS_dx10_label.csv", col_types = "ccc")
CCS_pr10_map   <- read_csv("data-raw/CCS/CCS_pr10_map.csv", col_types = "cccc")
CCS_pr10_label <- read_csv("data-raw/CCS/CCS_pr10_label.csv", col_types = "ccc")

usethis::use_data(CCS_dx10_map, overwrite = TRUE)
usethis::use_data(CCS_dx10_label, overwrite = TRUE)
usethis::use_data(CCS_pr10_map, overwrite = TRUE)
usethis::use_data(CCS_pr10_label, overwrite = TRUE)

rm(CCS_dx10_map, CCS_dx10_label,
   CCS_pr10_map, CCS_pr10_label)

####    ~ Metadata     ####
# Update metadata
metadata <- jsonlite::read_json("data-raw/metadata.json", simplifyVector = T)

metadata[["CCS_icd10"]] <- list(
  CCS_dx10 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/ccsr_archive.jsp",
    data_url = data_url_dx,
    version  = "Beta Version of the CCS for ICD-10-CM (v2019.1, beta)"
  ),
  CCS_pr10 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/ccsr_archive.jsp",
    data_url = data_url_pr,
    version  = "Beta Version of the CCS for ICD-10-PCS (v2020.1, beta)"
  ),
  download_date = Sys.Date()
)
metadata %>% jsonlite::write_json("data-raw/metadata.json")
rm(metadata, d, data_url_dx, data_url_pr)






#### CLEAN UP ENVIROMENT ####
unlink(d) # remove temp directory
rm(d, data_url_dx, data_url_pr)



