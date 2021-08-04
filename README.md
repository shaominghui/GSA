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
* Chr: chromosome number of the segment
* id: the number of the segment on each chromosome
* loc.start: start locus of the segment
* loc.end: end locus of the segment
* seg.len: the length of the segment
* events: the number of events in the segment
* nA: the copy number of A allele
* nB: the copy number of B allete

# How to generate the dependent segment file tumor purity and tumor ploidy files?
Unfortunately we are not able to share the segment modelling script publically, as it is part of our commercial product [华然迪®](https://oncology.bgi.com/huarandi.html) Also, our segment algorithm has many components that are customized for our HRD panel, and is normally not compatible with external data.

A potential way to generate the segment file tumor purity and tumor ploidy files is by using the ASCAT algorithm developed by Peter Van Loo et al. in [Allele-specific copy number analysis of tumors](https://www.pnas.org/content/107/39/16910?with-ds=yes), and the software (R package) can be found [Here](https://www.crick.ac.uk/research/labs/peter-van-loo/software) or using the PurceCN algorithm developed by Markus Riester et al. in [PureCN: copy number calling and SNV classification using targeted short read sequencing](https://link.springer.com/article/10.1186/s13029-016-0060-z),and the software can be found [Here](http://bioconductor.org/packages/release/bioc/html/PureCN.html).
