FROM ubuntu:18.04
LABEL simple samtools dockerfile
ENV MINICONDA_VERSION="3-4.5.4"
ENV BWA_VERSION="0.7.17"
ENV BOWTIE2_VERSION="2.3.4.3"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/code/conda/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>

RUN apt-get  update --fix-missing && \
  apt-get install -y \
  apt-utils \
  autoconf \
  bzip2 \
  build-essential \
  ca-certificates \
  curl \
  dlocate \
  git \
  gosu \
  libpcre3-dev \
  libtool \
  procps \
  uuid-runtime \
  wget \
  zlib1g-dev

WORKDIR /opt

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda${MINICONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh
RUN chmod ugo+x miniconda.sh 


SHELL ["/bin/bash", "-c","-l"]
RUN ./miniconda.sh -b -p /code/conda
RUN echo ". /code/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

RUN echo "MINICONDA_VERSION=${MINICONDA_VERSION}" > /code/repro.log
RUN conda install bwa=$BWA_VERSION bowtie2=$BOWTIE2_VERSION
RUN echo "bwa_version=$BWA_VERSION" >> /code/repro.log
RUN echo "bowtie2_version=$BOWTIE2_VERSION" >> /code/repro.log
RUN for package in $(dpkg --get-selections | cut -f 1); do dlocate -s "$package"; done | grep -P "^(Package|Version)" > /code/repro-dpkg-packages.txt

WORKDIR /code
COPY entrypoint.sh /code

CMD /code/entrypoint.sh
VOLUME ["/data"]
