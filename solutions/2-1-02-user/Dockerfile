FROM ubuntu:18.04
LABEL simple samtools dockerfile
ENV MINICONDA_VERSION="3-4.5.4"
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

RUN conda install cutadapt

WORKDIR /code
COPY entrypoint.sh /code
RUN conda install cutadapt
RUN git clone https://github.com/dcjones/fastq-tools
WORKDIR /code/fastq-tools
RUN ./autogen.sh && ./configure && make && make install

RUN echo "MINICONDA_VERSION=${MINICONDA_VERSION}" > /code/repro.log
RUN echo "cutadapt_version="$(cutadapt --version) >> /code/repro.log
RUN echo "fastq-tools_version="$(git rev-parse HEAD) >> /code/repro.log
RUN for package in $(dpkg --get-selections | cut -f 1); do dlocate -s "$package"; done | grep -P "^(Package|Version)" > /code/repro-dpkg-packages.txt


COPY entrypoint.sh /code/
ENTRYPOINT /code/entrypoint.sh /data/input.fastq /data/output.fastq
VOLUME ["/data"]
