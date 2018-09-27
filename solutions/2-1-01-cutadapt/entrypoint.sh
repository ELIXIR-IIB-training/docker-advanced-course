#!/bin/bash

cp /code/repro* /data
sha1sum /data/input.fastq > /data/repro-input.sha1
cutadapt -a TATCCTTG -o /data/.temp.fastq $1
fastq-uniq /data/.temp.fastq > $2
rm -f /data/.temp.fastq
