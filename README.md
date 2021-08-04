# GSA
# What is it?

The GSA (Genomic Scar Analysis) method is an independent development algorithm for calling copy number and detecting Homologous Recombination Deficiency (HRD) from target capture sequencing.

# The input of GSA
The input data format of GSA is (i) BAF data and (ii) LRR data.BAF(B allele frequency) represents the median SNP genotype frequency of each capture region and LRR (Log R ratio )represents the normalized depth ratio of the tumor and the normal sample (or blood cell control set) in each capture region after GC-bias correction.
For example files, see demo.BAF.txt and demo.LRR.txt in the input folder under the test directory.

# The output of GSA
The main output files of GSA are demo.segmentation.txt, demo.purity_ploidy.txt, demo_segmentation.pdf, demo_clust.PNG; see the output folder under the test directory for details.

# What does each column in the demo.segmentation.txt file mean?
A line in the demo.segmentation.txt file represents a segment in the genome, and each column means:
* Chr:
* id:
* loc.start:
* loc.end:
* seg.len:
* events:
* nA:
* nB:
