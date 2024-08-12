"""
Script to manipulate existing simonii VCF files to make them compatible with reh R package
for extended haplotype homozygosity statistical analysis 

Written by Jennifer Gilby for Dr. Liz Cooper's Lab Meetings Spring 2024
Evolutionary biology statistics presentation
"""

import numpy as np
import pandas as pd


outfile = "simonii-chr2-ancestral.vcf"
with open(outfile, 'w') as fout: 

    with open("simonii-chr2-thinned.recode.vcf", 'r') as vcf:
        
        for line in vcf:
            
            if line.startswith('##fileformat'): 
                fout.write(line)
                # need to write in ##INFO meta data line AA/Ancestral Allele 
                fout.write('##INFO=<ID=AA,Number=1,Type=String,Description="Ancestral Allele">\n')
            
            elif line.startswith('#'):
                fout.write(line)
            
            else:
                line = line.strip()
                line = line.split('\t')
                # INFO is index 7, REF allele is index 3
                line[7] = "AA=" + line[3]

                for element in line:
                    fout.write(element)

                    # add a tab to all but final element 
                    if line.index(element) != 28:
                        fout.write('\t')
                fout.write('\n')

# ## test code 
# with open("simonii-chr2-thinned.recode.vcf", 'r') as vcf:
#     for line in vcf:
#         print(line)                