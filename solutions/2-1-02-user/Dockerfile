FROM ubuntu:18.04
LABEL simple samtools dockerfile
ENV MINICONDA_VERSION="3-4.5.4"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/conda/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Gianluca Della Vedova <gianluca@dellavedova.org>

RUN apt-get  update --fix-missing && \
  apt-get install -y \
  apt-utils \
  bzip2 \
  build-essential \
  ca-certificates \
  curl \
  dlocate \
  git \
  gosu \
  wget \
  procps \
  uuid-runtime

WORKDIR /opt

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda${MINICONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh
RUN chmod ugo+x miniconda.sh 


SHELL ["/bin/bash", "-c","-l"]
RUN ./miniconda.sh -b -p /opt/conda
RUN rm -f miniconda.sh
RUN /opt/conda/bin/conda clean -tipsy
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate base" >> ~/.bashrc

WORKDIR /code
COPY entrypoint.sh /code
RUN git clone https://github.com/dcjones/fastq-tools
WORKDIR /code/fastq-tools
RUN ./configure && make && make install

RUN echo "MINICONDA_VERSION=${MINICONDA_VERSION}" > /data/repro.log
RUN conda install cutadapt
RUN echo "cutadapt_version="$(cutadapt --version) >> /data/repro.log
RUN echo "fastq-tools_version="$(git rev-parse HEAD) >> /data/repro.log
RUN for package in $(dpkg --get-selections | cut -f 1); do dlocate -s "$package"; done | grep -P "^(Package|Version)" > /data/repro-dpkg-packages.txt

ENTRYPOINT /code/entrypoint.sh /data/input.fastq /data/output.fastq
VOLUME ["/data"]
