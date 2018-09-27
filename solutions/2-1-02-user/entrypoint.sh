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

exec gosu user cp /code/repro* /data
exec gosu user sha1sum /data/input.fastq > /data/repro-input.sha1
exec gosu user cutadapt -a AACCGGTT -o /data/.temp.fastq $1
exec gosu user /code/fastq-tools/fastq-uniq /data/.temp.fastq $2
exec gosu user rm -f /data/.temp.fastq
