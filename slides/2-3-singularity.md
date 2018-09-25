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
 
/opt/
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
									  
```
\normalsize
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
	singularity:2.6.0
```
# Singularity: build

Example of simple Singularity file

# Singularity: build w/ Docker Registry

Example of my Singularity file getting data from Docker Registry
