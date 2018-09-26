---
title: Singularity
---

# Singularity

A container technology with two goals in mind

**Image Generator**: image can be generated starting from other containers
**Runtime**: Does not trust users so it has been design to be secure

# Singularity

* Software stack reproducible and verifiable
* Mobile, the container is a file that can be moved
* Runs eveywhere, fits really good in an HPC environment
* Does not trust users :)


# Singulrarity: install

\tiny
```
$ apt update &&\
  apt install autoconf \
			automake \
			autotools-dev \
            build-essential \
			git \
			libarchive-dev \
			libtool \
			squashfs-tools \
			python 
 
cd /opt/
rm -rf singularity && rm /usr/local/bin/singularity
git clone https://github.com/singularityware/singularity.git
cd singularity
git checkout tags/2.6.0 -b 2.6.0
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install 									  
```
\normalsize

# Singulrarity: install
in a Dockerfile

\tiny
```
FROM ubuntu:18.04

RUN apt update &&\
    apt install autoconf \
			automake \
			autotools-dev \
            build-essential \
			git \
			libarchive-dev \
			libtool \
			squashfs-tools \
			python 
 
WORKDIR /opt/

RUN git clone \
    https://github.com/singularityware/singularity.git
	
WORKDIR singularity

RUN git checkout tags/2.6.0 -b 2.6.0 &&\
	./autogen.sh &&\
	./configure --prefix=/usr/local &&\
	make &&\
	make install 
	
WORKDIR /
									  
```
\normalsize
# Singularity: running w/ Docker

Run singularity inside Docker, this is tricky

```
$ docker run --rm -it singularity:2.6.0
```

# Singularity: running w/ Docker

Run singularity inside Docker, this is tricky

```
$ docker run --rm -it singularity:2.6.0
```

Errors are behind the corner :)

# Singularity: running w/ Docker

Docker can run a container with special privileges
to access hosts' devices 

```
$ docker run \
	--priviledged
	--rm \
	-it \
	--link registry
	-v /path/to/Singularity:/build
	singularity:2.6.0
```
# Singularity: build from public DockerHub

```
cd /build
sudo singularity build ubuntu.simg docker://ubuntu:18.04
```

# Singularity: the Dockerfile
Create a file called `Singularity`
```
Bootstrap: docker
From: registry:5000/raoul/ubuntu:18.04
```

Remember to save the file into the `/build` directory


# Singularity: build w/ Docker Registry

```
cd /build
SINGULARITY_NOHTTPS=true singularity build ubuntu.18.04.simg Singularity
```

Check if there is a new file.
`SINGULARITY_NOHTTPS=true` is important becuase our registry is not secure

# Singularity: build a simple Singularity

\scriptsize
```
From: continuumio/miniconda3

%environment
    export PATH=/opt/conda/bin:$PATH

%post
    apt-get update -y && apt-get install -y curl bash bzip2 uuid-runtime procps build-essential

    . /.singularity.d/env/90-environment.sh
    conda update -n base conda
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda

    conda install readline=7.0
    pip install --upgrade pip
    pip install boto3 awscli

    mkdir -p /run/shm

%label
 Author Raoul Jean Pierre Bonnal
 Email bonnal@ingm.org
 ```
 \normalsize
