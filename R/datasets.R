#### CCSR_DX_mapping ####
#' Mapping ICD-10-CM (diagnosis) codes to CCSR categories.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software Refined (CCSR)
#' for ICD-10-CM Diagnoses.
#'
#' @format
#' \describe{
#'   \item{I10_DX}{ICD-10-CM diagnosis code, without decimials}
#'   \item{I10DX_text}{Description of the ICD-10-CM diagnosis code}
#'   \item{default_CCSR_IP}{The default CCSR category for the principal
#'         diagnosis for inpatient data}
#'   \item{default_CCSR_OP}{The default CCSR category for first-listed
#'         diagnosis for outpatient data}
#'   \item{CCSR1}{}
#'   \item{CCSR2}{}
#'   \item{CCSR3}{}
#'   \item{CCSR4}{}
#'   \item{CCSR5}{}
#'   \item{CCSR6}{CCSR categories assigned to a given ICD code. Some
#'                codes have multiple categories. See example below}
#'   The ICD-10-CM diagnosis code I11.9, Hypertensive heart disease without
#'   heart failure, maps to a single CCSR category (CIR008 – Hypertension
#'   with complications and secondary hypertension), whereas ICD-10-CM
#'   diagnosis code I11.0, Hypertensive heart disease with heart failure,
#'   maps to two CCSR categories (CIR008 – Hypertension with complications
#'   and secondary hypertension and CIR019 – Heart failure)
#' }
#' @keywords datasets
#' @details
#' The overarching goal of the CCSR is to categorize codes into a manageable
#' number of clinically meaningful categories. The categories themselves should
#' capture a clinical concept, and the codes within a specific category should
#' maintain the clinical intent of that category. The version of CCSR used in
#' this package is **v2022.1**; The source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/dxccsr.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/DXCCSR_v2022-1.zip}
#'
"CCSR_DX_mapping"

#### CCSR_DX_categories ####
#' Categories for CCSR diagnosis groups (ICD-10-CM)
#'
#' @format
#' \describe{
#'   \item{CCSR}{CCSR category}
#'   \item{CCSR_desc}{Description of CCSR category}
#'   \item{First3}{First 3 letters of CCSR category}
#'   \item{I10DX_Chapter}{ICD-10-CM Diagnosis Chapter corresponding to
#'         3-character abbreviation}
#'   ...
#' }
#' @keywords datasets
#' @details
#' The version of CCSR used in this package is **v2022.1**; The source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/dxccsr.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/DXCCSR_v2022-1.zip}
"CCSR_DX_categories"

#### CCSR_PR_mapping ####
#' Mapping ICD-10-PCS (procedure) codes to CCSR categories.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software Refined (CCSR)
#' for ICD-10-PCS Procedures.
#'
#' @format
#' \describe{
#'   \item{I10_PR}{ICD-10-PCS procedure code, without decimials}
#'   \item{I10_PR_desc}{Description of the ICD-10-CM procedure code}
#'   \item{CCSR}{CCSR category assigned to the ICD code}
#'   \item{CCSR_desc}{Description of the CCSR category}
#' }
#' @keywords datasets
#' @details
#' The version of CCSR used in this package is **v2022.1**. The source documentation
#'  \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/prccsr.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/PRCCSR_v2022-1.zip}
"CCSR_PR_mapping"


#### CCSR_PR_categories ####
#' Categories for CCSR procedure groups (ICD-10-PCS)
#'
#' @format
#' \describe{
#'   \item{CCSR}{CCSR category}
#'   \item{CCSR_desc}{Description of CCSR category}
#'   \item{clinical_domain}{Clinical domain of CCSR category}
#'   \item{PCS_roots}{ICD-10-PCS Root Operations}
#'   \item{PCS_bodyparts}{ICD-10-PCS Body Parts}
#'   \item{PCS_devices}{ICD-10-PCS Devices}
#'   \item{PCS_approaches}{ICD-10-PCS Approaches}
#'   Columns starting with "PCS" contain comma separated values
#'   provided by the HCUP
#' }
#' @keywords datasets
#' @details
#' The version of CCSR used in this package is **v2022.1**. The source documentation
#'  \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/prccsr.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/PRCCSR_v2022-1.zip}
"CCSR_PR_categories"


#### CCI_icd10 ####
#' CCI for ICD-10-CM (beta version)
#'
#' Chronic Condition Indicator (CCI) for ICD-10-CM (beta version)
#'
#' @format
#' \describe{
#'   \item{I10_DX}{ICD-10-CM diagnosis code, without decimials}
#'   \item{I10_DX_desc}{Description of the ICD-10-CM diagnosis code}
#'   \item{CCI}{Categorical variable inidcating if the ICD code represents an
#'         acute or chronic condition (see below)}
#'   Starting in v2021.1 (beta version), the CCI tool for ICD-10-CM was expanded
#'   to identify four types of conditions:
#'   * __Acute__: Examples include aortic embolism, bacterial infection, pregnancy,
#'    and an initial encounter for an injury
#'   * __Chronic__: Examples include malignant cancer, diabetes, obesity,
#'   hypertension, and many mental health conditions
#'   * __Both__: Examples include persistent asthma with (acute) exacerbation,
#'   acute on chronic heart failure, and kidney transplant rejection
#'   * __Not Applicable__: Examples include external cause of morbidity codes,
#'   injury sequela codes, and codes starting with the letter Z for screening
#'   or observation
#'
#'   In previous version (using ICD-9-CM), CCI classified conditions as chronic
#'   or __NonChronic__, so caution should be used when appying the CCI on data
#'   using both ICD-9 and ICD-10.
#' }
#' @keywords datasets
#' @details
#' The version of CCI used in this package is **beta version v2021.1**; The source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/chronic_icd10.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/chronic_icd10/CCI-ICD10CM-v2021-1.zip}
"CCI_icd10"


#### CCI_icd9 ####
#' CCI for ICD-9-CM
#'
#' Chronic Condition Indicator (CCI) for ICD-9-CM
#'
#' @format
#' \describe{
#'   \item{I9_DX}{ICD-9-CM diagnosis code (as char), without decimials, and
#'                padded with white space, where applicable (see below)}
#'   \item{I9_DX_desc}{Description of the ICD-9-CM diagnosis code}
#'   \item{CCI}{Categorical variable inidcating if the ICD code represents an
#'         __chronic__ or __NonChronic__ condition. This is unlike the ICD-10
#'         beta version, so caution should be used when appying the CCI on data
#'         using both ICD-9 and ICD-10}
#'   \item{body_system}{Body system indicator of ICD-9 code, which is divided
#'        18 categories}
#'   ICD-9-CM codes are padded with whitespace, so shorter codes (\code{"0031 "})
#'   will be treated like longer codes (\code{"00320"})
#' }
#' @keywords datasets
#' @details
#' The version of CCI used in this package is **2015 version**; The source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/chronic/chronic.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/chronic/cci2015.csv}
"CCI_icd9"




#### proc_class_icd10 ####
#' Procedure Classes Refined for the ICD-10-PCS
#'
#' @format
#' \describe{
#'   \item{I10_PR}{ICD-10-PCS procedure code}
#'   \item{I10_PR_desc}{Description of the ICD-10-PCS procedure code}
#'   \item{proc_class}{Categorical variable inidcating Procedure Classes Refined (see below)}
#'   ICD-10-PCS procedure codes to one of four categories:
#'   * __Minor Diagnostic__: Nonoperating room procedures that are diagnostic
#'   (e.g. B244ZZZ, Ultrasonography of Right Heart)
#'   * __Minor Therapeutic__: Nonoperating room procedures that are therapeutic
#'   (e.g. 02HQ33Z, Insertion of Infusion Device into Right Pulmonary Artery,
#'   Percutaneous Approach)
#'   * __Major Diagnostic__: Procedures that are considered operating room procedures
#'   that are performed for diagnostic reasons (e.g. 02BV0ZX, Excision of Superior
#'   Vena Cava, Open Approach, Diagnostic)
#'   * __Major Therapeutic__: Procedures that are considered operating room procedures
#'   that are performed for therapeutic reasons (e.g. 0210093, Bypass Coronary Artery,
#'   One Site from Coronary Artery with Autologous Venous Tissue, Open Approach).
#' }
#' @keywords datasets
#' @details
#' The version of Procedure Classes Refined used in this package is version **v2022.2**;
#' The source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10/procedure_icd10.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/procedureicd10/PClassR_v2022-2.zip}
"proc_class_icd10"


#### proc_class_icd9 ####
#' Procedure Classes for the ICD-9-CM procedure codes
#'
#' @format
#' \describe{
#'   \item{I9_PR}{ICD-9-CM procedure code, without decimials, left justified}
#'   \item{I9_PR_desc}{Description of the ICD-9-CM procedure code}
#'   \item{proc_class}{Categorical variable inidcating Procedure Classes (see below)}
#'   ICD-9-CM procedure codes to one of four categories:
#'   * __Minor Diagnostic__: Non-operating room procedures that are diagnostic (e.g., 87.03
#'   CT scan of head)
#'   * __Minor Therapeutic__: Non-operating room procedures that are therapeutic (e.g.,
#'   02.41 Irrigate ventricular shunt)
#'   * __Major Diagnostic__: All procedures considered valid operating room procedures by
#'   the Diagnosis Related Group (DRG) grouper and that are performed for diagnostic reasons
#'   (e.g., 01.14 Open brain biopsy)
#'   * __Major Therapeutic__: All procedures considered valid operating room procedures by
#'   the Diagnosis Related Group (DRG) grouper and that are performed for therapeutic reasons
#'   (e.g., 39.24 Aorta-renal bypass).
#' }
#' @keywords datasets
#' @details
#' The version of Procedure Classes used in this package is **2015 version**;
#' The source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/procedure/procedure.jsp}{can be found here}
#' @source
#' \url{https://www.hcup-us.ahrq.gov/toolssoftware/procedure/pc2015.csv}
"proc_class_icd9"

#### CCS_dx9_map ####
#' Lookup table for ICD-9-CM (diagnosis) codes to CCS categories.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software (CCS)
#' for ICD-9-CM Diagnoses.
#'
#' @format
#' \describe{
#'   \item{I9_DX}{ICD-9-CM diagnosis codes, without decimials}
#'   \item{CCS}{The single-level CCS category}
#'   \item{CCS_lvl1}{}
#'   \item{CCS_lvl2}{}
#'   \item{CCS_lvl3}{}
#'   \item{CCS_lvl4}{The multi-level CCS categoreis}
#' }
#' @keywords datasets
#' @details
#'
#' ## Single vs Multi-level CCS categories
#'
#' Unlike the CCS (CCS Refined), the original CCS classification
#' has "single-level" and "multi-level" categories.
#'
#' This system classifies all diagnoses and procedures into unique groups.
#' The single-level CCS aggregates diagnoses into 285 mutually exclusive
#' categories and procedures into 231 mutually exclusive categories.
#'
#' The multi-level CCS expands the single-level CCS into a hierarchical
#' system. The multi-level system has four levels for diagnoses and three
#' levels for procedures, which provide the opportunity to examine general
#' groupings or to assess very specific conditions and procedures. The
#' multi-level CCS groups single-level CCS categories into broader
#' body systems or condition categories (e.g., "Diseases of the Circulatory
#' System," "Mental Disorders," and "Injury").
#'
#' An example using CCS for diagnosis codes is shown below:
#'
#' \tabular{lll}{
#'   **CCS_lvl1** \tab **CCS_level2** \tab **CCS (single-level)** \cr
#'     DX-1       \tab   DX-1.1       \tab `DX1, DX2, DX3, DX9`   \cr
#'     DX-1       \tab   DX-1.2       \tab `DX4`                  \cr
#'     DX-1       \tab   DX-1.3       \tab `DX5, DX6, DX7`        \cr
#'     DX-1       \tab   DX-1.4       \tab `DX8`                  \cr
#'     DX-1       \tab   DX-1.5       \tab `DX10`
#' }
#'
#' It also splits single-level CCS categories to provide more detail.
#' For example, the single-level CCS diagnosis category `4` (_Mycoses_)
#' can be further split into 1.2.1 (_Candidiasis of the mouth_) and
#' 1.2.2 (_Other mycoses_).
#'
#' Further details can be found on the
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccsfactsheet.jsp}{CCS fact sheet}.
#'
#' ## Problems with the original notation
#' The notation used in the original CCS categories has a few limitations
#' in how it names categories.
#'
#' First, the CCS category `CCS = '3'` maps to "_Other bacterial
#' infections_" for diagnostic codes, but the same category (`CCS = '3'`)
#' maps to "Laminectomy" for procedures. Second, the CCS category is
#' supposed to be treated as a string (because HCUP designs their software
#' for SAS), but R will appropriately assume these categories are numbers.
#'
#' The third issue is the ambiguity of _single-level_ and _multi-level_ CCS
#' categories. In the original software, the first level of the _multi-level_
#' CCS uses the same syntax as the _single-level_ categories. For example,
#' "4" represents "Mycoses" as a _single-level_ category, but maps to
#' "Diseases of the blood and blood-forming organs" as a _multi-level_ category!
#'
#' This all turns out to be incredibly confusing as the same number `"3"` could
#' represent:
#' * _"Other bacterial infections"_ if it's the single-level category
#' for a diagnosis
#' * _"Endocrine; nutritional; and metabolic diseases and immunity disorders"_ if
#' it's the multi-level category for a diagnosis
#' * _"Laminectomy"_ if it's the single-level category for a procedure
#' * _"Operations on the eye"_ if it's the multi-level category for a procedure
#'
#'
#' ## Notation used in this package
#' To address these issues, this package prepends **"DX"**
#' or **"PR"** before the *default CCS category* (e.g. `3` becomes `DX3` or `PR3`
#' for diagnoses or procedures, respectively). For the *multi-level categories*,
#' the prefixes are **"DX-"** and **"PR-"**.
#'
#' Although this is a trivial change for most applications, it is mentioned
#' here because (for the purposes of reproducibility) this notation should
#' be changed back to the original format for any publications or uses beyond this
#' package.
#'
#'
#' @source
#' #' The source documentation used to derive this dataset
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccs.jsp}{can be found here}.
#'
#' The
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/Single_Level_CCS_2015.zip}{single-level}
#' and
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/Multi_Level_CCS_2015.zip}{multi-level}
#' zip files can be downloaded directly via their respective links.
"CCS_dx9_map"



#### CCS_pr9_map ####
#' Lookup table for ICD-9-CM (procedure) codes to CCS categories.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software (CCS)
#' for ICD-9-CM Procedure codes
#'
#' @format
#' \describe{
#'   \item{I9_DX}{ICD-9-CM procedure codes, without decimials}
#'   \item{CCS}{The single-level CCS category}
#'   \item{CCS_lvl1}{}
#'   \item{CCS_lvl2}{}
#'   \item{CCS_lvl3}{The multi-level CCS categoreis}
#' }
#' @keywords datasets
#' @details
#'
#' ## Single vs Multi-level CCS categories
#'
#' Unlike the CCS (CCS Refined), the original CCS classification
#' has "single-level" and "multi-level" categories.
#'
#' This system classifies all diagnoses and procedures into unique groups.
#' The single-level CCS aggregates diagnoses into 285 mutually exclusive
#' categories and procedures into 231 mutually exclusive categories.
#'
#' The multi-level CCS expands the single-level CCS into a hierarchical
#' system. The multi-level system has four levels for diagnoses and three
#' levels for procedures, which provide the opportunity to examine general
#' groupings or to assess very specific conditions and procedures. The
#' multi-level CCS groups single-level CCS categories into broader
#' body systems or condition categories (e.g., "Diseases of the Circulatory
#' System," "Mental Disorders," and "Injury").
#'
#' An example using CCS for diagnosis codes is shown below, but it's
#' similar for procedures
#'
#' \tabular{lll}{
#'   **CCS_lvl1** \tab **CCS_level2** \tab **CCS (single-level)** \cr
#'     DX-1       \tab   DX-1.1       \tab `DX1, DX2, DX3, DX9`   \cr
#'     DX-1       \tab   DX-1.2       \tab `DX4`                  \cr
#'     DX-1       \tab   DX-1.3       \tab `DX5, DX6, DX7`        \cr
#'     DX-1       \tab   DX-1.4       \tab `DX8`                  \cr
#'     DX-1       \tab   DX-1.5       \tab `DX10`
#' }
#'
#' It also splits single-level CCS categories to provide more detail.
#' For example, the single-level CCS procedure category `3` (_Laminectomy_)
#' can be further split into 1.3.1 (_Excision of intervertebral disc_) and
#' 1.3.2 (_Laminectomy_).
#'
#' Further details can be found on the
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccsfactsheet.jsp}{CCS fact sheet}.
#'
#' ## Problems with the original notation
#' The notation used in the original CCS categories has a few limitations
#' in how it names categories.
#'
#' First, the CCS category `CCS = '3'` maps to "_Other bacterial
#' infections_" for diagnostic codes, but the same category (`CCS = '3'`)
#' maps to "Laminectomy" for procedures. Second, the CCS category is
#' supposed to be treated as a string (because HCUP designs their software
#' for SAS), but R will appropriately assume these categories are numbers.
#'
#' The third issue is the ambiguity of _single-level_ and _multi-level_ CCS
#' categories. In the original software, the first level of the _multi-level_
#' CCS uses the same syntax as the _single-level_ categories. For example,
#' "4" represents "Mycoses" as a _single-level_ category, but maps to
#' "Diseases of the blood and blood-forming organs" as a _multi-level_ category!
#'
#' This all turns out to be incredibly confusing as the same number `"3"` could
#' represent:
#' * _"Other bacterial infections"_ if it's the single-level category
#' for a diagnosis
#' * _"Endocrine; nutritional; and metabolic diseases and immunity disorders"_ if
#' it's the multi-level category for a diagnosis
#' * _"Laminectomy"_ if it's the single-level category for a procedure
#' * _"Operations on the eye"_ if it's the multi-level category for a procedure
#'
#'
#' ## Notation used in this package
#' To address these issues, this package prepends **"DX"**
#' or **"PR"** before the *default CCS category* (e.g. `3` becomes `DX3` or `PR3`
#' for diagnoses or procedures, respectively). For the *multi-level categories*,
#' the prefixes are **"DX-"** and **"PR-"**.
#'
#' Although this is a trivial change for most applications, it is mentioned
#' here because (for the purposes of reproducibility) this notation should
#' be changed back to the original format for any publications or uses beyond this
#' package.
#'
#'
#' @source
#' #' The source documentation used to derive this dataset
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/ccs.jsp}{can be found here}.
#'
#' The
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/Single_Level_CCS_2015.zip}{single-level}
#' and
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs/Multi_Level_CCS_2015.zip}{multi-level}
#' zip files can be downloaded directly via their respective links.
"CCS_pr9_map"


#### CCS_dx10_map ####
#' Lookup table for ICD-10-CM (diagnosis) codes to CCS categories.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software (CCS)
#' beta version for ICD-10-CM Diagnoses.
#'
#' @format
#' \describe{
#'   \item{I10_DX}{ICD-10-CM diagnosis codes, without decimials}
#'   \item{CCS}{The single-level CCS category}
#'   \item{CCS_lvl1}{}
#'   \item{CCS_lvl2}{The multi-level CCS categoreis}
#' }
#' @keywords datasets
#' @details
#'
#' ## Single vs Multi-level CCS categories
#'
#' Unlike the CCS (CCS Refined), the original CCS classification
#' has "single-level" and "multi-level" categories.
#'
#' This system classifies all diagnoses and procedures into unique groups.
#' The single-level CCS aggregates diagnoses into 285 mutually exclusive
#' categories and procedures into 231 mutually exclusive categories.
#'
#' The multi-level CCS expands the single-level CCS into a hierarchical
#' system. The multi-level system has four levels for diagnoses and three
#' levels for procedures, which provide the opportunity to examine general
#' groupings or to assess very specific conditions and procedures. The
#' multi-level CCS groups single-level CCS categories into broader
#' body systems or condition categories (e.g., "Diseases of the Circulatory
#' System," "Mental Disorders," and "Injury").
#'
#' An example using CCS for diagnosis codes is shown below:
#'
#' \tabular{lll}{
#'   **CCS_lvl1** \tab **CCS_level2** \tab **CCS (single-level)** \cr
#'     DX-1       \tab   DX-1.1       \tab `DX1, DX2, DX3, DX9`   \cr
#'     DX-1       \tab   DX-1.2       \tab `DX4`                  \cr
#'     DX-1       \tab   DX-1.3       \tab `DX5, DX6, DX7`        \cr
#'     DX-1       \tab   DX-1.4       \tab `DX8`                  \cr
#'     DX-1       \tab   DX-1.5       \tab `DX10`
#' }
#'
#' ## Problems with the original notation
#' The notation used in the original CCS categories has a few limitations
#' in how it names categories.
#'
#' First, the CCS category `CCS = '3'` maps to "_Other bacterial
#' infections_" for diagnostic codes, but the same category (`CCS = '3'`)
#' maps to "Laminectomy" for procedures. Second, the CCS category is
#' supposed to be treated as a string (because HCUP designs their software
#' for SAS), but R will appropriately assume these categories are numbers.
#'
#' The third issue is the ambiguity of _single-level_ and _multi-level_ CCS
#' categories. In the original software, the first level of the _multi-level_
#' CCS uses the same syntax as the _single-level_ categories. For example,
#' "4" represents "Mycoses" as a _single-level_ category, but maps to
#' "Diseases of the blood and blood-forming organs" as a _multi-level_ category!
#'
#' This all turns out to be incredibly confusing as the same number `"3"` could
#' represent:
#' * _"Other bacterial infections"_ if it's the single-level category
#' for a diagnosis
#' * _"Endocrine; nutritional; and metabolic diseases and immunity disorders"_ if
#' it's the multi-level category for a diagnosis
#' * _"Laminectomy"_ if it's the single-level category for a procedure
#' * _"Operations on the eye"_ if it's the multi-level category for a procedure
#'
#'
#' ## Notation used in this package
#' To address these issues, this package prepends **"DX"**
#' or **"PR"** before the *default CCS category* (e.g. `3` becomes `DX3` or `PR3`
#' for diagnoses or procedures, respectively). For the *multi-level categories*,
#' the prefixes are **"DX-"** and **"PR-"**.
#'
#' Although this is a trivial change for most applications, it is mentioned
#' here because (for the purposes of reproducibility) this notation should
#' be changed back to the original format for any publications or uses beyond this
#' package.
#'
#' ## Caution about CCS for ICD-10
#' Appendix A of the
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/DXCCSR-User-Guide-v2022-1.pdf}{CCSR user guide}
#' states that the "development of the beta version of the CCS for ICD-10-CM was
#' completed before ICD-10-CM-coded data became available. Once ICD-10-CM coded
#' data became available, the beta version of the CCS was evaluated through
#' preliminary analyses on HCUP data, which revealed unexpected discontinuities
#' between the ICD-9-CM and ICD-10-CM versions of the CCS."
#'
#' Because the beta version of CCS for ICD-10 was developed using the
#' \href{http://www.cms.gov/Medicare/Coding/ICD10/2014-ICD-10-CM-and-GEMs.html}{General Equivalence Mappings}
#' and is no longer being actively updated, applications that only use ICD-10 codes
#' may want to consider using the CCSR instead.
#'
#' @source
#' The version of CCS used in this package is **CCS v2019.1 (beta version)**; The
#' source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/ccsr_archive.jsp}{can be found here}.
#'
#' The source zip file can be
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs10/ccs_dx_icd10cm_2019_1.zip}{downloaded via this link}
#'
#'
"CCS_dx10_map"




#### CCS_pr10_map ####
#' Lookup table for ICD-10-PCS (procedure) codes to CCS categories.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software (CCS)
#' beta version for ICD-10-PCS procedures
#'
#' @format
#' \describe{
#'   \item{I10_PR}{ICD-10-PCS procedure codes, without decimials}
#'   \item{CCS}{The single-level CCS category}
#'   \item{CCS_lvl1}{}
#'   \item{CCS_lvl2}{The multi-level CCS categoreis}
#' }
#' @keywords datasets
#' @details
#'
#' ## Single vs Multi-level CCS categories
#'
#' Unlike the CCS (CCS Refined), the original CCS classification
#' has "single-level" and "multi-level" categories.
#'
#' This system classifies all diagnoses and procedures into unique groups.
#' The single-level CCS aggregates diagnoses into 285 mutually exclusive
#' categories and procedures into 231 mutually exclusive categories.
#'
#' The multi-level CCS expands the single-level CCS into a hierarchical
#' system. The multi-level system has four levels for diagnoses and three
#' levels for procedures, which provide the opportunity to examine general
#' groupings or to assess very specific conditions and procedures. The
#' multi-level CCS groups single-level CCS categories into broader
#' body systems or condition categories (e.g., "Diseases of the Circulatory
#' System," "Mental Disorders," and "Injury").
#'
#' An example using CCS for diagnosis codes is shown below:
#'
#' \tabular{lll}{
#'   **CCS_lvl1** \tab **CCS_level2** \tab **CCS (single-level)** \cr
#'     DX-1       \tab   DX-1.1       \tab `DX1, DX2, DX3, DX9`   \cr
#'     DX-1       \tab   DX-1.2       \tab `DX4`                  \cr
#'     DX-1       \tab   DX-1.3       \tab `DX5, DX6, DX7`        \cr
#'     DX-1       \tab   DX-1.4       \tab `DX8`                  \cr
#'     DX-1       \tab   DX-1.5       \tab `DX10`
#' }
#'
#' ## Problems with the original notation
#' The notation used in the original CCS categories has a few limitations
#' in how it names categories.
#'
#' First, the CCS category `CCS = '3'` maps to "_Other bacterial
#' infections_" for diagnostic codes, but the same category (`CCS = '3'`)
#' maps to "Laminectomy" for procedures. Second, the CCS category is
#' supposed to be treated as a string (because HCUP designs their software
#' for SAS), but R will appropriately assume these categories are numbers.
#'
#' The third issue is the ambiguity of _single-level_ and _multi-level_ CCS
#' categories. In the original software, the first level of the _multi-level_
#' CCS uses the same syntax as the _single-level_ categories. For example,
#' "4" represents "Mycoses" as a _single-level_ category, but maps to
#' "Diseases of the blood and blood-forming organs" as a _multi-level_ category!
#'
#' This all turns out to be incredibly confusing as the same number `"3"` could
#' represent:
#' * _"Other bacterial infections"_ if it's the single-level category
#' for a diagnosis
#' * _"Endocrine; nutritional; and metabolic diseases and immunity disorders"_ if
#' it's the multi-level category for a diagnosis
#' * _"Laminectomy"_ if it's the single-level category for a procedure
#' * _"Operations on the eye"_ if it's the multi-level category for a procedure
#'
#'
#' ## Notation used in this package
#' To address these issues, this package prepends **"DX"**
#' or **"PR"** before the *default CCS category* (e.g. `3` becomes `DX3` or `PR3`
#' for diagnoses or procedures, respectively). For the *multi-level categories*,
#' the prefixes are **"DX-"** and **"PR-"**.
#'
#' Although this is a trivial change for most applications, it is mentioned
#' here because (for the purposes of reproducibility) this notation should
#' be changed back to the original format for any publications or uses beyond this
#' package.
#'
#' ## Caution about CCS for ICD-10
#' Appendix A of the
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/DXCCSR-User-Guide-v2022-1.pdf}{CCSR user guide}
#' states that the "development of the beta version of the CCS for ICD-10-CM was
#' completed before ICD-10-CM-coded data became available. Once ICD-10-CM coded
#' data became available, the beta version of the CCS was evaluated through
#' preliminary analyses on HCUP data, which revealed unexpected discontinuities
#' between the ICD-9-CM and ICD-10-CM versions of the CCS."
#'
#' Because the beta version of CCS for ICD-10 was developed using the
#' \href{http://www.cms.gov/Medicare/Coding/ICD10/2014-ICD-10-CM-and-GEMs.html}{General Equivalence Mappings}
#' and is no longer being actively updated, applications that only use ICD-10 codes
#' may want to consider using the CCSR instead.
#'
#' @source
#' The version of CCS used in this package is **CCS v2020.1 (beta version)**; The
#' source documentation
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/ccsr_archive.jsp}{can be found here}.
#'
#' The source zip file can be
#' \href{https://www.hcup-us.ahrq.gov/toolssoftware/ccs10/ccs_pr_icd10pcs_2020_1.zip}{downloaded via this link}
"CCS_pr10_map"





#### CCS_xxx_label ####
#' Look up the names of CCS categories from CCS codes.
#'
#' A dataset extracted from the  Healthcare Cost and Utilization
#' Project's (HCUP) Clinical Classifications Software (CCS)
#' for ICD-9-CM Procedure codes
#'
#' @name CCS_xxx_label
#' @format
#' \describe{
#'   \item{CCS}{Vector of CCS categories}
#'   \item{CCS_label}{Text description of the CCS category}
#'   \item{CCS_Level}{A column indicating what level the code belongs
#'     to. If `main`, then it's a CCS code for single-level CCS. Otherwise,
#'     it will be `lvl(n)`, where n is the level in the multi-level schema}
#' }
#' @keywords datasets
#'
NULL


#' @rdname CCS_xxx_label
#' @format NULL
"CCS_dx9_label"

#' @rdname CCS_xxx_label
#' @format NULL
"CCS_dx10_label"

#' @rdname CCS_xxx_label
#' @format NULL
"CCS_pr9_label"

#' @rdname CCS_xxx_label
#' @format NULL
"CCS_pr10_label"



#### XXXX ####
#### XXXX ####
#### XXXX ####
#### XXXX ####

