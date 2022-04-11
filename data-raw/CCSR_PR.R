## SOURCE URL
# https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/prccsr.jsp

library(dplyr)
library(stringr)
library(usethis)
library(readr)

#### READ FILES ####
data_url <- "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/PRCCSR_v2022-1.zip"

# Read the zip file and extract files
d <- tempdir()

# Read the files
archive::archive_extract(data_url,
                         dir  = d,
                         files = c("PRCCSR_v2022-1.CSV",
                                   "PRCCSR-Reference-File-v2022-1.xlsx"))

df_mapping <- readr::read_csv(file = glue::glue("{d}/PRCCSR_v2022-1.CSV"),
                              skip = 1,
                              col_types = "ccccc",
                              col_names = c("I10_PR", "I10_PR_desc", "CCSR", "CCSR_desc", "Domain")) %>%
  select(-Domain) %>%
  mutate(across(c("I10_PR", "CCSR"), str_remove_all, "\\'"))



df_categories <- readxl::read_excel(glue::glue("{d}/PRCCSR-Reference-File-v2022-1.xlsx"),
                                    sheet = "CCSR Categories",
                                    col_names = c("CCSR", "CCSR_desc",
                                                  "clinical_domain",
                                                  "PCS_roots",
                                                  "PCS_bodyparts",
                                                  "PCS_devices",
                                                  "PCS_approaches"),
                                    skip = 2)

unlink(d) # remove temp directory
rm(d)


####   WRITE TO FILE   ####
####  ~ Write to CSV   ####
readr::write_csv(df_mapping,    "data-raw/CCSR/CCSR_PR_mapping.csv")
readr::write_csv(df_categories, "data-raw/CCSR/CCSR_PR_categories.csv")
rm(df_mapping, df_categories)


#### ~ Write to object ####
CCSR_PR_mapping    <- read_csv("data-raw/CCSR/CCSR_PR_mapping.csv", col_types="cccc")
CCSR_PR_categories <- read_csv("data-raw/CCSR/CCSR_PR_categories.csv", col_types="ccccccc")

usethis::use_data(CCSR_PR_mapping, overwrite = T)
usethis::use_data(CCSR_PR_categories, overwrite = T)

rm(CCSR_PR_mapping) # We'll use CCSR_PR_categories below


####    ~ Metadata     ####
# Update metadata
metadata <- jsonlite::read_json("data-raw/metadata.json", simplifyVector = T)

metadata[["CCSR_PR"]] <- list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/prccsr.jsp",
    data_url = data_url,
    version  = "CCSR v2022.1",
  download_date = Sys.Date()
)
metadata %>% jsonlite::write_json("data-raw/metadata.json")

rm(metadata, data_url)

#### SPECIAL FORMAT ####
# MAKE LISTS FROM THE COMMA SEPARATED VALUES
# These "CSVs" are nested within the columns, and are not encoded in a
# friendly format. For example, CAR001 (heart biopsy) has the body part
# listed as:
#     "Ventricle, Right", Ventricular Septum, "Ventricle, Left", ...
#
# The portion listed above should be treated as three seperate items:
#  1. Ventricle, Right
#  2. Ventricular Septum
#  3. Ventricle, Left
#
seperate_dirty_csv <- function(string){
  text <- textConnection(string)
  read.table(text, allowEscapes = TRUE, stringsAsFactors=F, sep = ",") %>%
    t() %>%
    unlist() %>%
    str_trim()
}

if(FALSE){ # example to demonstrate the point
  sample_csv <- '"Ventricle, Right", Ventricular Septum, "Ventricle, Left"'

  # Incorrect
  str_split(sample_csv, ",")

  # Correct
  seperate_dirty_csv(sample_csv)
}


# We will run this on all of the PCS columns to make list-columns
# within the PCS positions of the code (i.e. the last four positions
# of the ICD code)
CCSR_PR_categories_lists <- CCSR_PR_categories %>%
  mutate(across(starts_with("PCS_"), ~purrr::map(.x, seperate_dirty_csv)))

usethis::use_data(CCSR_PR_categories_lists, internal = T)

# # example application idnetifying all categories potentially
# # involving a central vein
# CCSR_PR_categories_lists %>%
#   filter(purrr::map_lgl(PCS_bodyparts, ~"Central Vein" %in% .x))






