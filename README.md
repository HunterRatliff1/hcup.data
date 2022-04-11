
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hcup.data

<!-- badges: start -->

<!-- badges: end -->

This package provides datasets used by the [Healthcare Cost and
Utilization Project
(HCUP)](https://www.hcup-us.ahrq.gov/tools_software.jsp).

## Installation

You can install the development version of hcup.data from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("HunterRatliff1/hcup.data")
```

## Data included

Below are the datasets in this package. Use `?<dataset>` for
details

| dataset              | description                                                      |
| :------------------- | :--------------------------------------------------------------- |
| CCI\_icd10           | CCI for ICD-10-CM (beta version)                                 |
| CCI\_icd9            | CCI for ICD-9-CM                                                 |
| CCSR\_DX\_categories | Categories for CCSR diagnosis groups (ICD-10-CM)                 |
| CCSR\_DX\_mapping    | Mapping ICD-10-CM (diagnosis) codes to CCSR categories.          |
| CCSR\_PR\_categories | Categories for CCSR procedure groups (ICD-10-PCS)                |
| CCSR\_PR\_mapping    | Mapping ICD-10-PCS (procedure) codes to CCSR categories.         |
| CCS\_dx10\_label     | Look up the names of CCS categories from CCS codes.              |
| CCS\_dx10\_map       | Lookup table for ICD-10-CM (diagnosis) codes to CCS categories.  |
| CCS\_dx9\_label      | Look up the names of CCS categories from CCS codes.              |
| CCS\_dx9\_map        | Lookup table for ICD-9-CM (diagnosis) codes to CCS categories.   |
| CCS\_pr10\_label     | Look up the names of CCS categories from CCS codes.              |
| CCS\_pr10\_map       | Lookup table for ICD-10-PCS (procedure) codes to CCS categories. |
| CCS\_pr9\_label      | Look up the names of CCS categories from CCS codes.              |
| CCS\_pr9\_map        | Lookup table for ICD-9-CM (procedure) codes to CCS categories.   |
| proc\_class\_icd10   | Procedure Classes Refined for the ICD-10-PCS                     |
| proc\_class\_icd9    | Procedure Classes for the ICD-9-CM procedure codes               |
