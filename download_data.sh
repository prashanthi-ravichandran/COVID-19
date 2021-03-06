#!/bin/bash
set -e

#Set up directories
datadir=GTEx_data
mkdir -p ${datadir}
mkdir -p ${datadir}/tissue_tpm
mkdir -p ${datadir}/SVA_corrected


outdir=results
mkdir -p ${outdir}
mkdir -p ${outdir}/plots

cd ${datadir}


#Download the data from GTEX:
#TPM data
wget https://storage.googleapis.com/gtex_analysis_v8/rna_seq_data/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct.gz
gunzip  GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct.gz
TPM="GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct"

#Subject phenotypes:
wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt
#Sample annotations:
wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
#Covariates data
wget https://storage.googleapis.com/gtex_analysis_v8/single_tissue_qtl_data/GTEx_Analysis_v8_eQTL_covariates.tar.gz
tar -xvf GTEx_Analysis_v8_eQTL_covariates.tar.gz
rm GTEx_Analysis_v8_eQTL_covariates.tar.gz

#Get annotation data from gencode
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_26/gencode.v26.annotation.gtf.gz
gunzip gencode.v26.annotation.gtf.gz
#reformat it for convenience.
awk '(!/^#/) {print $10,$14,$16}'  gencode.v26.annotation.gtf | sed 's/[";]//g' | uniq  >  gencode.v26.annotation.gene.txt
