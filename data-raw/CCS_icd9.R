# Referance URL: https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccs.jsp
library(dplyr)
library(tidyr)
# library(purrr)
library(stringr)
library(readr)
library(usethis)



#### READ FILES ####
data_url_single <- "https://www.hcup-us.ahrq.gov/toolssoftware/ccs/Single_Level_CCS_2015.zip"
data_url_multi  <- "https://www.hcup-us.ahrq.gov/toolssoftware/ccs/Multi_Level_CCS_2015.zip"

# Read the zip file and extract files
d <- tempdir()

# Read the files
archive::archive_extract(data_url_single,
                         dir  = d,
                         files = c("dxlabel 2015.csv", "$dxref 2015.csv",
                                   "prlabel 2014.csv", "$prref 2015.csv"))
archive::archive_extract(data_url_multi,
                         dir  = d,
                         files = c("ccs_multi_dx_tool_2015.csv", "dxmlabel-13.csv",
                                   "ccs_multi_pr_tool_2015.csv", "prmlabel-09.csv"))

####    ICD-9 DX    ####
#### ~ Join icd9 dx ####
i9_single_dx <- readr::read_csv(file = glue::glue("{d}/$dxref 2015.csv"), skip = 2,
                                col_types = "cccccc",
                                col_names = c("I9_DX",
                                              "CCS", "CCS_desc",
                                              "I9_DX_desc",
                                              "optCCS", "optCCS_desc")) %>%

  select(-optCCS, -optCCS_desc) %>%
  # Remove the quotes
  mutate(CCS_desc = str_remove_all(CCS_desc, "\\'"),
         CCS_desc = str_trim(CCS_desc),
         CCS = str_remove_all(CCS, "\\'"),
         CCS = str_trim(CCS),
         CCS = str_glue("DX{CCS}"),
         CCS = as.character(CCS),
         I9_DX = str_remove_all(I9_DX, "\\'"),
         I9_DX = str_trim(I9_DX)) %>%

  # Fix issue with one label being wrong
  mutate(CCS_desc = recode(CCS_desc, "Septicemia (except in labor)"="Septicemia"))



i9_multi_dx <- readr::read_csv(file = glue::glue("{d}/ccs_multi_dx_tool_2015.csv"),
                               skip = 1,
                               col_types = "ccccccccc",
                               col_names = c("I9_DX",
                                             "CCS_lvl1_code", "CCS_lvl1_desc",
                                             "CCS_lvl2_code", "CCS_lvl2_desc",
                                             "CCS_lvl3_code", "CCS_lvl3_desc",
                                             "CCS_lvl4_code", "CCS_lvl4_desc"))  %>%

  # Remove the quotes
  mutate(across(matches("CCS_lvl._code"), str_remove_all, "\\'"),
         across(matches("CCS_lvl._code"), str_trim),
         across(matches("CCS_lvl._code"), na_if, ""),
         across(matches("CCS_lvl._code"), ~ifelse(!is.na(.x), paste0("DX-", .x), .x)),
         across(matches("CCS_lvl._code"), as.character),
         I9_DX = str_remove_all(I9_DX, "\\'"),
         I9_DX = str_trim(I9_DX))

# Join these together to mimick the format of CCS for ICD-10
df_i9_dx <- left_join(i9_single_dx, i9_multi_dx, by="I9_DX") %>%
  filter(I9_DX!="")
rm(i9_single_dx, i9_multi_dx)

#### ~ Seperate icd9 dx ####
CCS_dx9_map <- df_i9_dx %>%
  select(-ends_with("_desc")) %>%
  rename_with(~str_remove(.x, "_code"))



# Take all of the descriptions and make a tidy df
# with thier CCS categories
CCS_dx9_label <- df_i9_dx %>%
  rename(CCS_main_code=CCS, CCS_main_desc=CCS_desc) %>%
  select(-I9_DX, -I9_DX_desc) %>%
  pivot_longer(everything(),
               names_to      = c("level", ".value"),
               names_pattern = "CCS_(....)_(....)") %>%
  select(CCS=code, CCS_label=desc, CCS_Level=level) %>%
  filter(!is.na(CCS)) %>%
  mutate(CCS_label = recode(CCS_label, "Mental Illness"="Mental illness",
                            "Miscellaneous mental health disorders [670]"="Miscellaneous mental disorders [670]")) %>%
  unique()


####    ICD-9 PR    ####
#### ~ Join icd9 pr ####
i9_single_pr <- readr::read_csv(file = glue::glue("{d}/$prref 2015.csv"), skip = 2,
                                col_types = "cccc",
                                col_names = c("I9_PR", "CCS", "CCS_desc",
                                              "I9_PR_desc")) %>%

  # Remove the quotes
  mutate(CCS_desc = str_remove_all(CCS_desc, "\\'"),
         CCS_desc = str_trim(CCS_desc),
         CCS = str_remove_all(CCS, "\\'"),
         CCS = str_trim(CCS),
         CCS = str_glue("PR{CCS}"),
         CCS = as.character(CCS),
         I9_PR = str_remove_all(I9_PR, "\\'"),
         I9_PR = str_trim(I9_PR))

i9_multi_pr <- readr::read_csv(file = glue::glue("{d}/ccs_multi_pr_tool_2015.csv"),
                               skip = 1,
                               col_types = "ccccccc",
                               col_names = c("I9_PR",
                                             "CCS_lvl1_code", "CCS_lvl1_desc",
                                             "CCS_lvl2_code", "CCS_lvl2_desc",
                                             "CCS_lvl3_code", "CCS_lvl3_desc")) %>%

  # Remove the quotes
  mutate(across(matches("CCS_lvl._code"), str_remove_all, "\\'"),
         across(matches("CCS_lvl._code"), str_trim),
         across(matches("CCS_lvl._code"), na_if, ""),
         across(matches("CCS_lvl._code"), ~ifelse(!is.na(.x), paste0("PR-", .x), .x)),
         across(matches("CCS_lvl._code"), as.character),
         I9_PR = str_remove_all(I9_PR, "\\'"),
         I9_PR = str_trim(I9_PR))



# Join these together to mimick the format of CCS for ICD-10
df_i9_pr <- left_join(i9_single_pr, i9_multi_pr, by="I9_PR") %>%
  filter(I9_PR!="")
rm(i9_single_pr, i9_multi_pr)

#### ~ Seperate icd9 pr ####
CCS_pr9_map <- df_i9_pr %>%
  select(-ends_with("_desc")) %>%
  rename_with(~str_remove(.x, "_code"))



# Take all of the descriptions and make a tidy df
# with thier CCS categories
CCS_pr9_label <- df_i9_pr %>%
  rename(CCS_main_code=CCS, CCS_main_desc=CCS_desc) %>%
  select(-I9_PR, -I9_PR_desc) %>%
  pivot_longer(everything(),
               names_to      = c("level", ".value"),
               names_pattern = "CCS_(....)_(....)") %>%
  select(CCS=code, CCS_label=desc, CCS_Level=level) %>%
  filter(!is.na(CCS)) %>%
  unique()





####   WRITE TO FILE   ####
####  ~ Write to CSV   ####
readr::write_csv(CCS_dx9_map,   "data-raw/CCS/CCS_dx9_map.csv")
readr::write_csv(CCS_dx9_label, "data-raw/CCS/CCS_dx9_label.csv")
readr::write_csv(CCS_pr9_map,   "data-raw/CCS/CCS_pr9_map.csv")
readr::write_csv(CCS_pr9_label, "data-raw/CCS/CCS_pr9_label.csv")
rm(CCS_dx9_map, CCS_dx9_label, df_i9_dx,
   CCS_pr9_map, CCS_pr9_label, df_i9_pr)

#### ~ Write to object ####
CCS_dx9_map   <- readr::read_csv("data-raw/CCS/CCS_dx9_map.csv", col_types ="cccccc")
CCS_dx9_label <- readr::read_csv("data-raw/CCS/CCS_dx9_label.csv", col_types="ccc")
CCS_pr9_map   <- readr::read_csv("data-raw/CCS/CCS_pr9_map.csv", col_types="ccccc")
CCS_pr9_label <- readr::read_csv("data-raw/CCS/CCS_pr9_label.csv", col_types="ccc")

usethis::use_data(CCS_dx9_map, overwrite = T)
usethis::use_data(CCS_dx9_label, overwrite = T)
usethis::use_data(CCS_pr9_map, overwrite = T)
usethis::use_data(CCS_pr9_label, overwrite = T)

rm(CCS_dx9_map, CCS_dx9_label,
   CCS_pr9_map, CCS_pr9_label)

####    ~ Metadata     ####
# Update metadata
metadata <- jsonlite::read_json("data-raw/metadata.json", simplifyVector = T)

metadata[["CCS_icd9"]] <- list(
  CCS_dx9 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccs.jsp",
    data_url = list(single = data_url_single, multi = data_url_multi),
    version  = "2015 version"
  ),
  CCS_pr9 = list(
    help_url = "https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccs.jsp",
    data_url = list(single = data_url_single, multi = data_url_multi),
    version  = "2015 version"
  ),
  download_date = Sys.Date()
)
metadata %>% jsonlite::write_json("data-raw/metadata.json")

unlink(d) # remove temp directory
rm(metadata, d, data_url_single, data_url_multi)


