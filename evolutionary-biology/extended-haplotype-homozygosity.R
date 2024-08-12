## EXTENDED HAPLOTYPE HOMOZYGOSITY USING REHH PACKAGE 
# adapted based on tutorial provided by: https://cran.r-project.org/web/packages/rehh/vignettes/examples.html 
# R script to do extended haplotype homozygosity on simonii vcf data for Cooper Lab meeting presentation


setwd("/Users/jennifergilby/cooperLab/EHH_analysis")

## install and load rehh 
install.packages('rehh') 
library(rehh)

## install and load rehh (need to read in VCF file)
install.packages('vcfR') 
library(vcfR)

## ALTERNATIVE:
##install and load data.table package (extension of dataframe, also for reading in vcf) 
install.packages('data.table') 
library(data.table)


## instantiate haplotype object 
hh <- data2haplohh(hap_file = "simonii-chr2-ancestral.vcf",
                       vcf_reader = "vcfR")

## initial plot (not great for visualizing a lot of data)
## red is ancestral, blue is derived 
plot(hh)

## generate all information for all snps (148) and individuals (20)
haplo(hh)

## calculate ehh around 1 snp (chose 116)
res <- calc_ehh(hh, mrk = 116, include_nhaplo = TRUE)
res
# plot EHH for this snp 
plot(res)




### GENOME WIDE SCAN
# because we have a good amount of data, this is where things get interesting 

# generates unnormalized ancestral and dreived IHH values for all alleles and individuals  
res.scan <- scan_hh(hh, discard_integration_at_border = FALSE)
res.scan

# normalize IHHS values by setting bin = 1
ihs <- ihh2ihs(res.scan, freqbin = 1, verbose = FALSE)
ihs

# find candidate regions for significant IHHS 
cr <- calc_candidate_regions(ihs, threshold = 2, ignore_sign = TRUE, window_size = 1)
cr

# plot 
# note an IHHS value over 2, under -2 is significant 
manhattanplot(ihs, threshold = c(-2,2), cr = cr, ylim = c(-2.5,2.5), pch = 20)
