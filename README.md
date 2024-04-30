
# cBioportal

![](https://img.shields.io/badge/Version-v6.0.5-blue?style=flat-square)
![](https://img.shields.io/badge/Totall%20Rank-99.96%25-brightgreen?style=flat-square&link=https%3A%2F%2Fwww.cbioportal.org%2F)
![](https://img.shields.io/badge/Open%20Access-100%25-green?style=flat-square)

## cBio Cancer Genomics Portal

### Online database

Gene mutation data for Cancer Genomics

<https://www.cbioportal.org/>

The cBioPortal for Cancer Genomics is a resource for interactive
exploration of multidimensional cancer genomics data sets. The portal
supports and stores non-synonymous mutations, DNA copy-number data, mRNA
and microRNA expression data, protein-level and phosphoprotein level
data (RPPA or mass spectrometry based), DNA methylation data, and
de-identified clinical data.

### R client

There are multiple ways to access the API using R.

One of the recommended R packages to access cBioPortal data is
**cBioPortalData** package.

# cBioPortalData

![](https://img.shields.io/badge/version-2.12.0-blue?style=flat-square)
![](https://img.shields.io/badge/rank-308%2F2266-blue?style=flat-square)
![](https://img.shields.io/badge/In%20Bioconductor-4%20years-yellowgreen?style=flat-square)
![](https://img.shields.io/badge/Depends-R%20(%3E%3D%204.3.0)-success?style=flat-square)
![](https://img.shields.io/badge/Platforms-All-%2397ca00?style=flat-square)

[cBioPortal/github](waldronlab.io/cBioPortalData/)

[Bioconductor.cBioPortalData.package](https://bioconductor.org/packages/release/bioc/html/cBioPortalData.html#archives)

## Overview

The `cBioPortalData` R package accesses cancer datasets from the cBio
Cancer Genomics Portal. The package provides cBioPortal datasets as
[MultiAssayExperiment](https://bioconductor.org/packages/3.19/MultiAssayExperiment)
objects in Bioconductor.

Thanks to [waldronlab/cBioPortalData](objects%20into%20Bioconductor.)

### MultiAssayExperiment

According to
[Bioconductor.MultiAssayExperiment](https://bioconductor.org/packages/3.19/bioc/html/MultiAssayExperiment.html#:~:text=DOI%3A%2010.18129/B9.bioc.MultiAssayExperiment),
harmonized and managed data of multiple experimental assays performed on
an overlapping set of specimens by MultiAssayExperiment.

# **Installation**

To install this package in R (version \>= "4.3.0"), `BiocManager`
package should be used:

```{r}
BiocManager::install("cBioPortalData")
```

loading package

```{r}
library(cBioPortalData)
```

getting the information of *cBioPortal* *API* :

a list of all api datasets of studies that are available and currently
building as *MultiAssayExperiment* representations.

```{r}
cbio <- cBioPortal()
```

```         
service: cBioPortal
tags(); use cbioportal$<tab completion>:
# A tibble: 65 x 3
   tag                 operation                            summary
   <chr>               <chr>                                <chr>  
 1 Cancer Types        getAllCancerTypesUsingGET            Get al~
 2 Cancer Types        getCancerTypeUsingGET                Get a ~
 3 Clinical Attributes fetchClinicalAttributesUsingPOST     Fetch ~
 4 Clinical Attributes getAllClinicalAttributesInStudyUsin~ Get al~
 5 Clinical Attributes getAllClinicalAttributesUsingGET     Get al~
 6 Clinical Attributes getClinicalAttributeInStudyUsingGET  Get sp~
 7 Clinical Data       fetchAllClinicalDataInStudyUsingPOST Fetch ~
 8 Clinical Data       fetchClinicalDataUsingPOST           Fetch ~
 9 Clinical Data       getAllClinicalDataInStudyUsingGET    Get al~
10 Clinical Data       getAllClinicalDataOfPatientInStudyU~ Get al~
# i 55 more rows
# i Use `print(n = ...)` to see more rows
tag values:
  Cancer Types, Clinical Attributes, Clinical Data, Copy
  Number Segments, Discrete Copy Number Alterations, Gene
  Panel Data, Gene Panels, Generic Assay Data, Generic
  Assays, Genes, Info, Molecular Data, Molecular Profiles,
  Mutations, Patients, Sample Lists, Samples, Server
  running status, Studies, Treatments
schemas():
  AlleleSpecificCopyNumber, AlterationFilter,
  AndedPatientTreatmentFilters,
  AndedSampleTreatmentFilters, CancerStudy
  # ... with 58 more elements
```

releasing the studies available in *cbio* and making a matrix of full
information about all api studies including study ID :

$Note$ : The studies with `permission=TRUE` is represented.

```{r}
study <- getStudies(cbio)
```

## studyID selection

-   Choosing a particular cancer study with **TCGA** studyID ([GDC
    portal](https://portal.gdc.cancer.gov/)). This function will provide
    sample lists of the study selected based on *cbio* in
    *MultiAssayExperiment* using `sampleLists` function based on
    **TCGA** study id. ( *SKCM-TCGA* study is an example here).

-   *SampleListid* column will be added to the table with study id and
    description.

```{r}
sample <- sampleLists(studyId = "skcm_tcga",cbio)
```

```{r}
colnames(sample)
```

```         
[1] "category"     "name"         "description"  "sampleListId"
[5] "studyId"  
```

```{r}
table(sample$category)
```

```         
#      all_cases_in_study 
#                                            1 
#                      all_cases_with_cna_data 
#                                            1 
#              all_cases_with_methylation_data 
#                                            2 
#              all_cases_with_mrna_rnaseq_data 
#                                            1 
# all_cases_with_mutation_and_cna_and_mrna_data 
#                                            1 
#         all_cases_with_mutation_and_cna_data 
#                                            1 
#                 all_cases_with_mutation_data 
#                                            1 
#                     all_cases_with_rppa_data
```

$Note$: we can see variant sample categories for the study id including
**mutation data**.

### downloading a particular study

It allows users to download sections of the data with molecular profile and gene panel combinations within a study.

```
SKCM <- cBioPortalData(api = cbio, studyId = "skcm_tcga",by ="hugoGeneSymbol",
 
                       molecularProfileIds = c("skcm_tcga_mutations"),

                       sampleListId = "skcm_tcga_3way_complete",
 
                       genePanelId = "IMPACT341")
```

```
SKCM
#> A MultiAssayExperiment object of 2 listed
#> experiments with user-defined names and respective classes.
#> Containing an ExperimentList class object of length 2:
#> [1] skcm_tcga_mutations: RangedSummarizedExperiment with 3798 rows and 283 columns
#> [2] skcm_tcga_rna_seq_v2_mrna: SummarizedExperiment with 341 rows and 287 columns
#> Functionality:
#> experiments() - obtain the ExperimentList instance
#> colData() - the primary/phenotype DataFrame
#> sampleMap() - the sample coordination DataFrame
#> `$`, `[`, `[[` - extract colData columns, subset, or experiment
#> *Format() - convert into a long or wide DataFrame
#> assays() - convert ExperimentList to a SimpleList of matrices
#> exportClass() - save data to flat files
```

