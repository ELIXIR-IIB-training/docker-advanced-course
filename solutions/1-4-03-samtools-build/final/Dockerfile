FROM ubuntu:18.04
LABEL simple samtools dockerfile
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>

RUN apt-get update && apt-get install -y \
  automake \
  autoconf-archive \
  bash-completion \
  build-essential \
  debhelper \
  libbz2-dev \
  libhts-dev \
  libhts2 \
  libio-pty-perl \
  libncurses5-dev \
  pkg-config \
  tabix \
  wget \
  zlib1g-dev

WORKDIR "/data"
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
 tar xjf samtools-1.9.tar.bz2

WORKDIR  "/data/samtools-1.9"
RUN ./configure && make && make install


ENTRYPOINT samtools 2> /data/samtools.txt
VOLUME ["/data"]
