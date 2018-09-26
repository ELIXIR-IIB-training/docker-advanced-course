---
title: Advanced Docker Course
header-includes:
-  \lstset{basicstyle=\ttfamily,breaklines=false}
-  \lstset{backgroundcolor=\color{black!10},frame=TRBL, frameround=tttt}
-  \setmonofont{Ubuntu Mono}
- \hypersetup{colorlinks=true}
---

# Use Case: Comparing Aligners

We want to compare some short-read aligners (all of them are available via conda):

*  BWA
*  Bowtie2
*  Gmap
*  STAR

We want to run those programs, and to store the results outside the container for a later analysis.

The data are stored [here](https://github.com/ELIXIR-IIB-training/docker-advanced-course/data)

# Using the aligners

## BWA

*  `bwa index lambda_virus.fa.gz` to build the index
*  `bwa aln lambda_virus.fa.gz reads_1.fq.gz -f reads_1.fq.gz.sai` to build the *sai* file
*  `bwa samse lambda_virus.fa.gz reads_1.fq.gz.sai reads_1.fq.gz -f results` to compute the alignments


## Bowtie2

*  the index is already built
*  `bowtie2 -x index/lambda_virus -U reads_1.fq.gz` to compute the alignments


# Using the aligners

## Gmap

*  `bwa index data/lambda_virus.fa.gz` to build the index
*  `bwa mem data/lambda_virus.fa.gz data/reads_1.fq.gz` to compute the alignments


## STAR

*  the index is already built
*  `bowtie2 -x data/index/lambda_virus -U data/reads_1.fq.gz` to compute the alignments


