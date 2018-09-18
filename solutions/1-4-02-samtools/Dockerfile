FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
    samtools


ENTRYPOINT samtools 2> /data/samtools.txt
VOLUME ["/data"]
