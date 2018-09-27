FROM ubuntu:18.04
LABEL Building samtools from source
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

WORKDIR "/code"
RUN wget --quiet https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
RUN tar xjf samtools-1.9.tar.bz2

WORKDIR  "/code/samtools-1.9"
RUN ./configure && make

ENV PATH=/code/samtools-1.9:$PATH
CMD samtools 2> /data/samtools.txt
VOLUME ["/data"]
