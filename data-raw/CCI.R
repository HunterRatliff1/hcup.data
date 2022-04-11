library(dplyr)
library(stringr)
library(usethis)
library(readr)

####--- CCI for ICD-10 ---####
## SOURCE URL
# https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/chronic_icd10.jsp
data_url_10 <- "https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/CCI-ICD10CM-v2021-1.zip"

d <- tempdir()
archive::archive_extract(data_url_10,
                         dir  = d,
                         files = "CCI_ICD10CM_v2021-1.csv")

CCI_icd10 <- readr::read_csv(file = glue::glue("{d}/CCI_ICD10CM_v2021-1.csv"),
                             skip = 3,
                             col_names = c("I10_DX", "I10_DX_desc", "CCI")) %>%
  mutate(across(everything(), str_remove_all, "\\'"),
         CCI = recode(CCI, "A"="Acute", "C"="Chronic",
                      "B"="Both", "N"="Not Applicable"))



CCI_icd10 %>% readr::write_csv("data-raw/CCI/CCI_icd10.csv")
unlink(d) # remove temp directory
rm(CCI_icd10, d)





####--- CCI for ICD-9 ---####
## Source url: https://www.hcup-us.ahrq.gov/toolssoftware/chronic/chronic.jsp
data_url_9 <- "https://www.hcup-us.ahrq.gov/toolssoftware/chronic/cci2015.csv"

body_systems <- tibble::tribble(
  ~BodySystem_abbv,  ~body_system,
  "1",               "Infectious and parasitic disease",
  "2",               "Neoplasms",
  "3",               "Endocrine, nutritional, and metabolic diseases and immunity disorders",
  "4",               "Diseases of blood and blood-forming organs",
  "5",               "Mental disorders",
  "6",               "Diseases of the nervous system and sense organs",
  "7",               "Diseases of the circulatory system",
  "8",               "Diseases of the respiratory system",
  "9",               "Diseases of the digestive system",
  "10",              "Diseases of the genitourinary system",
  "11",              "Complications of pregnancy, childbirth, and the puerperium",
  "12",              "Diseases of the skin and subcutaneous tissue",
  "13",              "Diseases of the musculoskeletal system",
  "14",              "Congenital anomalies",
  "15",              "Certain conditions originating in the perinatal period",
  "16",              "Symptoms, signs, and ill-defined conditions",
  "17",              "Injury and poisoning",
  "18",              "Factors influencing health status and contact with health services"
)



# Read the data a recode SAS variables to char
df <- readr::read_csv(data_url_9, skip = 2,col_types = "cccc",
                      col_names = c("I9_DX", "I9_DX_desc", "CCI", "BodySystem_abbv")) %>%
  mutate(across(everything(), str_remove_all, "\\'"),
         CCI = recode(CCI, "0"="NonChronic", "1"="Chronic"),
         I9_DX = str_trim(I9_DX)) %>%
  left_join(body_systems, by = "BodySystem_abbv") %>%
  select(-BodySystem_abbv)

readr::write_csv(df, "data-raw/CCI/CCI_icd9.csv")
rm(df, body_systems)



#### WRITE TO OBJECTS ####
CCI_icd10 <- readr::read_csv("data-raw/CCI/CCI_icd10.csv", col_types = "ccc")
usethis::use_data(CCI_icd10, overwrite = TRUE)

CCI_icd9 <- readr::read_csv("data-raw/CCI/CCI_icd9.csv", col_types = "cccc")
usethis::use_data(CCI_icd9, overwrite = TRUE)

rm(CCI_icd10, CCI_icd9)

# Update metadata
metadata <- jsonlite::read_json("data-raw/metadata.json", simplifyVector = T)

metadata[["CCI"]] <- list(
  CCI_icd10 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/chronic_icd10.jsp",
    data_url = data_url_10,
    version  = "Chronic Condition Indicator for ICD-10-CM (beta version) v2021.1"
  ),
  CCI_icd9 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/chronic/chronic.jsp",
    data_url = data_url_9,
    version  = "Chronic Condition Indicator 2015 version"
  ),
  download_date = Sys.Date()
)
metadata %>% jsonlite::write_json("data-raw/metadata.json")
rm(metadata)
