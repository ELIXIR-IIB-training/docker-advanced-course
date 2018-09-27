FROM ubuntu:18.04
LABEL cutadapt + fastq-uniq pipeline
ENV MINICONDA_VERSION="3-4.5.11"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/code/conda/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>

RUN apt-get update --fix-missing
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
RUN apt-get install -y libpcre3-dev

WORKDIR /code

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda${MINICONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh
RUN chmod ugo+x miniconda.sh 


SHELL ["/bin/bash", "-c","-l"]
RUN ./miniconda.sh -b -p /code/conda
RUN echo ". /code/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

RUN conda install cutadapt
RUN apt-get install -y autoconf
RUN apt-get install -y libtool
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y dlocate


WORKDIR /code
COPY entrypoint.sh /code

RUN git clone https://github.com/dcjones/fastq-tools
WORKDIR /code/fastq-tools
RUN ./autogen.sh && ./configure && make && make install



RUN echo "MINICONDA_VERSION=${MINICONDA_VERSION}" > /code/repro.log
RUN echo "cutadapt_version="$(cutadapt --version) >> /code/repro.log
RUN echo "fastq-tools_version="$(git rev-parse HEAD) >> /code/repro.log
RUN for package in $(dpkg --get-selections | cut -f 1); do dlocate -s "$package"; done | grep -P "^(Package|Version)" > /code/repro-dpkg-packages.txt

CMD /code/entrypoint.sh /data/input.fastq /data/output.fastq
VOLUME ["/data"]
