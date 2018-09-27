FROM ubuntu:18.04
LABEL simple samtools dockerfile
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>

RUN apt-get update
RUN apt-get install -y automake
RUN apt-get install -y autoconf-archive
RUN apt-get install -y bash-completion
RUN apt-get install -y build-essential
RUN apt-get install -y debhelper
RUN apt-get install -y libbz2-dev
RUN apt-get install -y libhts-dev
RUN apt-get install -y libhts2
RUN apt-get install -y libio-pty-perl
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y pkg-config
RUN apt-get install -y tabix
RUN apt-get install -y wget
RUN apt-get install -y zlib1g-dev

WORKDIR "/code"
RUN wget --quiet https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
RUN tar xjf samtools-1.9.tar.bz2

WORKDIR  "/code/samtools-1.9"
RUN ./configure && make

ENV PATH=/code/samtools-1.9:$PATH
CMD samtools 2> /data/samtools.txt
VOLUME ["/data"]
