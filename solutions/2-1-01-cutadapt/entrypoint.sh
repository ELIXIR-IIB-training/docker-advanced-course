#!/bin/bash

/opt/bin/cutadapt -a AACCGGTT -o /data/.temp.fastq $1
/code/fastq-tools/fastq-uniq /data/.temp.fastq $2
rm -f /data/.temp.fastq
