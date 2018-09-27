FROM ubuntu:18.04
LABEL simple samtools dockerfile with conda
ENV MINICONDA_VERSION="3-4.5.4"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/code/conda/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>

RUN apt-get  update --fix-missing
RUN apt-get install -y \
  apt-utils \
  bzip2 \
  build-essential \
  ca-certificates \
  curl \
  git \
  wget \
  procps \
  uuid-runtime

WORKDIR /code

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda${MINICONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh
RUN chmod ugo+x miniconda.sh 


SHELL ["/bin/bash", "-c","-l"]
RUN ./miniconda.sh -b -p /code/conda
RUN echo ". /code/conda/etc/profile.d/conda.sh" >> ~/.bashrc


ENTRYPOINT samtools 2> /data/samtools.txt
VOLUME ["/data"]
