#!/bin/bash
# Add local user
# with the same owner as /data
USER_ID=$(stat -c %u /data)
GROUP_ID=$(stat -c %g /data)

echo "Starting with UID:GID $USER_ID:$GROUP_ID"
groupadd -g "$GROUP_ID" group
useradd --shell /bin/bash -u "$USER_ID" -g group -o -c "" -m user
export HOME=/
chown --recursive "$USER_ID":"$GROUP_ID" /data
echo "$PATH"

cd /data
echo "bwa index"
gosu user bwa index lambda_virus.fa.gz
echo "bwa aln"
gosu user bwa aln lambda_virus.fa.gz reads_1.fq.gz -f reads_1.fq.gz.sai
echo "bwa samse"
gosu user bwa samse lambda_virus.fa.gz reads_1.fq.gz.sai reads_1.fq.gz -f results
echo "bowtie2"
gosu user bowtie2 -x lambda_virus -U reads_1.fq.gz
