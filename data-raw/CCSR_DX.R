## SOURCE URL
# https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/dxccsr.jsp

library(dplyr)
library(tidyr)
# library(purrr)
library(stringr)
library(usethis)

data_url <- "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/DXCCSR_v2022-1.zip"

#### READ FILES ####
# Read the zip file and extract files
d <- tempdir()

# Read the files
archive::archive_extract(data_url,
                         dir  = d,
                         files = c("DXCCSR_v2022-1.CSV",
                                   "DXCCSR-Reference-File-v2022-1.xlsx"))

df_mapping <- readr::read_csv(file = glue::glue("{d}/DXCCSR_v2022-1.CSV"),
                              col_types = "cccccccccccccccccc")

df_categories <- readxl::read_excel(glue::glue("{d}/DXCCSR-Reference-File-v2022-1.xlsx"),
                                    sheet = "CCSR_Categories",
                                    col_names = c("CCSR", "CCSR_desc"),
                                    skip = 2)

df_chapters <- readxl::read_excel(glue::glue("{d}/DXCCSR-Reference-File-v2022-1.xlsx"),
                                  sheet = "Naming_Conventions",
                                  col_names = c("I10DX_Chapter", "First3"),
                                  skip = 2)

unlink(d) # remove temp directory
rm(d)


#### REFORMAT ####
# Rename the columns
names(df_mapping) <- c("I10DX_code",      "I10DX_text",
                       "default_CCSR_IP", "default_CCSR_IP_desc",
                       "default_CCSR_OP", "default_CCSR_OP_desc",
                       glue::glue("CCSR{rep(1:6, each=2)}{rep(c('', '_desc'), 6)}"))

CCSR_DX_mapping <- df_mapping %>%

  # Remove the extra quotations
  mutate(across(everything(), str_remove_all, "'")) %>%
  mutate(across(everything(), na_if, " ")) %>%

  # Drop extra columns, as we don't need them
  select(-ends_with("_desc")) %>%
  rename(I10_DX=I10DX_code)


# Join the ICD chapter to the category definitions
CCSR_DX_categories <- df_categories %>%
  mutate(First3 = str_extract(CCSR, "^\\w\\w\\w")) %>%
  left_join(df_chapters, by = "First3")

rm(df_mapping, df_chapters, df_categories)

####   WRITE TO FILE   ####
####  ~ Write to CSV   ####
readr::write_csv(CCSR_DX_mapping,    "data-raw/CCSR/CCSR_DX_mapping.csv")
readr::write_csv(CCSR_DX_categories, "data-raw/CCSR/CCSR_DX_categories.csv")

rm(CCSR_DX_mapping, CCSR_DX_categories)

#### ~ Write to object ####
CCSR_DX_mapping     <- read_csv("data-raw/CCSR/CCSR_DX_mapping.csv", col_types = "cccccccccc")
CCSR_DX_categories  <- read_csv("data-raw/CCSR/CCSR_DX_categories.csv", col_types = "cccc")

usethis::use_data(CCSR_DX_mapping)
usethis::use_data(CCSR_DX_categories)

rm(CCSR_DX_categories) # We'll use CCSR_DX_mapping below


####    ~ Metadata     ####
# Update metadata
metadata <- jsonlite::read_json("data-raw/metadata.json", simplifyVector = T)

metadata[["CCSR_DX"]] <- list(
  help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/dxccsr.jsp",
  data_url = data_url,
  version  = "CCSR v2022.1",
  download_date = Sys.Date()
)
metadata %>% jsonlite::write_json("data-raw/metadata.json")

rm(metadata, data_url)

#### SPECIAL FORMAT ####
# Make CCSR long format
CCSR_DX_tidy <- CCSR_DX_mapping %>%
  select(I10_DX, starts_with("CCSR")) %>%
  pivot_longer(!I10_DX, names_to="CCSR_n", values_to="CCSR") %>%
  filter(!is.na(CCSR))

CCSR_DX_ls <- CCSR_DX_tidy %>%
  group_by(CCSR) %>%
  summarise(CCSR_DX = list(I10_DX))

names(CCSR_DX_ls$CCSR_DX) <- CCSR_DX_ls$CCSR

usethis::use_data(CCSR_DX_tidy, internal = T, overwrite = T)


