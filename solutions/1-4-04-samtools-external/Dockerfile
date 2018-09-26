FROM ubuntu:18.04
LABEL simple samtools dockerfile
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>



ENTRYPOINT /code/samtools/bin/samtools 2> /data/samtools.txt
VOLUME ["/data", "/code"]
