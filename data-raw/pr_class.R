library(dplyr)
library(stringr)
library(readr)
library(usethis)

####--- PR class for ICD-10 ---####
## SOURCE URL
# https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10/procedure_icd10.jsp
data_url_10 <- "https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10/PClassR_v2022-2.zip"

d <- tempdir()
archive::archive_extract(data_url_10,
                         dir  = d,
                         files = "PClassR_v2022-2.csv")
proc_class_icd10 <- readr::read_csv(file = glue::glue("{d}/PClassR_v2022-2.csv"), skip = 2,
                                    col_names = c("I10_PR", "I10_PR_desc", "proc_class_num", "proc_class")) %>%
  mutate(I10_PR = str_remove_all(I10_PR, "\\'")) %>%
  select(-proc_class_num)


####--- PR class for ICD-10 ---####
## SOURCE URL
# https://www.hcup-us.ahrq.gov/toolssoftware/procedure/procedure.jsp
data_url_9 <- "https://www.hcup-us.ahrq.gov/toolssoftware/procedure/pc2015.csv"

# Read the data a recode SAS variables to char
proc_class_icd9 <- readr::read_csv(data_url_9,
                                   skip      = 3,
                                   col_types = "ccc",
                                   col_names = c("I9_PR", "I9_PR_desc", "proc_class")) %>%
  mutate(across(everything(), str_remove_all, "\\'"),
         proc_class = recode(proc_class,
                             "3" = "Major Diagnostic",
                             "4" = "Major Therapeutic",
                             "1" = "Minor Diagnostic",
                             "2" = "Minor Therapeutic"))

unlink(d) # remove temp directory
rm(d)



####   WRITE TO FILE   ####
####  ~ Write to CSV   ####
proc_class_icd10 %>% readr::write_csv("data-raw/pr_class/proc_class_icd10.csv")
proc_class_icd9  %>% readr::write_csv("data-raw/pr_class/proc_class_icd9.csv")

rm(proc_class_icd9, proc_class_icd10)



#### ~ Write to object ####
proc_class_icd10 <- read_csv("data-raw/pr_class/proc_class_icd10.csv", col_types = "ccc")
proc_class_icd9  <- read_csv("data-raw/pr_class/proc_class_icd9.csv", col_types = "ccc")

usethis::use_data(proc_class_icd10, overwrite = TRUE)
usethis::use_data(proc_class_icd9, overwrite = TRUE)

rm(proc_class_icd9, proc_class_icd10)


####    ~ Metadata     ####
# Update metadata
metadata <- jsonlite::read_json("data-raw/metadata.json", simplifyVector = T)

metadata[["proc_class"]] <- list(
  proc_class_icd10 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10/procedure_icd10.jsp",
    data_url = data_url_10,
    version  = "Procedure Classes Refined for ICD-10-PCS v2022.2"
  ),
  proc_class_icd9 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/procedure/procedure.jsp",
    data_url = data_url_9,
    version  = "2015 version"
  ),
  download_date = Sys.Date()
)
metadata %>% jsonlite::write_json("data-raw/metadata.json")

rm(metadata, data_url_9, data_url_10)

