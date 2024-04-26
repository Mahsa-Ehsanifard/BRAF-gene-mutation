
BiocManager::install("cBioPortalData")
library(cBioPortalData)
data<-data("studiesTable", package = "cBioPortalData")

cbio <- cBioPortal() #get the information of cbioportal
study <- getStudies(cbio) # get the studies for choosing my favorite study
sample <- sampleLists(studyId = "skcm_tcga",cbio) #get the samples for choosing my favorite sample
genepanel <- genePanels(cbio) #get gene panel information
panel <- getGenePanel(cbio, genePanelId = "IMPACT341")

#acheiving to my study analysis for mutation
SKCM <- cBioPortalData(api = cbio, studyId = "skcm_tcga",by ="hugoGeneSymbol",
                       molecularProfileIds = c("skcm_tcga_mutations","skcm_tcga_rna_seq_v2_mrna"),
                       sampleListId = "skcm_tcga_3way_complete",genePanelId = "IMPACT341")
