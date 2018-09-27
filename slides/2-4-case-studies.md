---
title: Advanced Docker Course
header-includes:
-  \lstset{basicstyle=\ttfamily,breaklines=false}
-  \lstset{backgroundcolor=\color{black!10},frame=TRBL, frameround=tttt}
-  \setmonofont{Ubuntu Mono}
- \hypersetup{colorlinks=true}
---

# Use Case: Comparing Aligners

We want to compare some short-read aligners (all of them are available via conda):

*  BWA
*  Bowtie2

We want to run those programs, and to store the results outside the container for a later analysis.

The data are stored [here](https://github.com/ELIXIR-IIB-training/docker-advanced-course/data)

# Using the aligners

## BWA

*  `bwa index lambda_virus.fa.gz` to build the index
*  `bwa aln lambda_virus.fa.gz reads_1.fq.gz -f reads_1.fq.gz.sai` to build the *sai* file
*  `bwa samse lambda_virus.fa.gz reads_1.fq.gz.sai reads_1.fq.gz -f results` to compute the alignments


## Bowtie2

*  the index is already built
*  `bowtie2 -x index/lambda_virus -U reads_1.fq.gz` to compute the alignments



# Use Case: Images for pipelines
## Base 
\tiny
```
FROM ubuntu:18.04

LABEL author="Raoul Jean Pierre Bonnal"
LABEL maintainer="bonnal@ingm.org"

ENV TINI_VERSION="v0.18.0"
ENV MINICONDA_VERSION="3-4.5.4"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/conda/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get  update --fix-missing && \
    apt-get install -y \
            apt-utils \
            bzip2 \
            build-essential \
	    ca-certificates \
	    curl \
	    git \
	    wget \
	    procps \
	    uuid-runtime 

WORKDIR /opt

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda${MINICONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh && \
    chmod ugo+x miniconda.sh

RUN ./miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -O /usr/bin/tini
RUN chmod +x /usr/bin/tini


SHELL ["/bin/bash", "-c","-l"]
RUN conda config --add channels defaults &&\
    conda config --add channels conda-forge &&\
    conda config --add channels bioconda

RUN conda install readline=7.0 &&\
    pip install pip==10.0.1 \
                boto3==1.7.50 \
                awscli==1.15.51

SHELL ["/bin/sh", "-c"]
RUN mkdir -p /mnt/home && \
    mkdir -p /run/shm

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
```
\normalsize


# Use Case: Images for pipelines
## Base 
\tiny
```
FROM  bionic-ingm-base:0.1

#
# How to build
# docker build -t ingm-elixir:0.1 .
# docker tag ingm-elixir:0.1 localhost:5000/ingm-elixir:0.1
# docker push localhost:5000/ingm-elixir:0.1
#
LABEL software.iread="https://www.biorxiv.org/content/early/2017/10/04/135624www.libpls.net/iread"

ENV DEBIAN_FRONTEND=noninteractive
#RUN apt-get update && install apt-get -y liblapack3 libboost1.62-dev gawk
RUN apt-get update && apt-get install -y pigz unzip libparallel-forkmanager-perl

# libparallel-forkmanager-perl required by iREAD 0.8.0
# argparse is requierd by iREAD 0.8.0


WORKDIR /opt

RUN conda create -n elixir python=2.7 &&\
    /bin/bash -c "source activate organoids && \
                  conda install -c bioconda \
					  samtools=1.8 \
					  bedops=2.4.35 \
					  argparse=1.4.0 \
					  fastqc=0.11.7 \
					  star=2.5.3a &&\
				  conda clean --all"

RUN curl -L -o BBMap_38.16.tar.gz "https://sourceforge.net/projects/bbmap/files/BBMap_38.16.tar.gz/download" &&\
    tar xzvf BBMap_38.16.tar.gz &&\
    rm BBMap_38.16.tar.gz

RUN curl -L -o iREAD_0.8.0.zip "http://www.genemine.org/codes/iREAD_0.8.0.zip" &&\
    (unzip iREAD_0.8.0.zip; exit 0) &&\
    ( find ./iREAD_0.8.0 -type f -name *.py -exec sed -i -e 's:/usr/bin/python:/usr/bin/env python:g' {} \; ) &&\
    ( find ./iREAD_0.8.0 -type f -name *.pl -exec sed -i -e 's:/usr/bin/perl:/usr/bin/env perl:g' {} \; ) &&\
    rm iREAD_0.8.0.zip

# This activate the elixir automatically, I guess there is a better way to do this
RUN echo "conda activate elixir" >> ~/.bashrc

ENV PATH=/opt/bbmap:/opt/iREAD_0.8.0:${PATH}

```
\normalsize
