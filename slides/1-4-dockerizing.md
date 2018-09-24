---
title: Advanced Docker Course
header-includes:
-  \lstset{basicstyle=\ttfamily,breaklines=false}
-  \lstset{backgroundcolor=\color{black!10},frame=TRBL, frameround=tttt}
-  \setmonofont{Ubuntu Mono}
---

# Dockerizing an application

Different kinds of application:

*   command line program, works on files (samtools)
*   long-running server (mysql), communicates via network
*   virtual machine (ubuntu)

We will focus on the first type

# Installing programs

Building an image is like administering a Linux computer

```
apt-get install ne
```
to install the program `ne`

Works on Ubuntu and Debian (and derivatives)

# Exercise 1

Build an image (i.e. write the Dockerfile) based on the ubuntu:18.04 image and runs the command 

```
df -h
```

saving the output in a directory outside the container.

```
docker run --rm -v $HOME/data:/data elixir1
```
can be used to run the container

What are the permission of the new file?

[Solution](https://github.com/ELIXIR-IIB-training/docker-advanced-course/solutions/1-4-01-df/Dockerfile)

# Exercise 2

Build an image (i.e. write the Dockerfile) that:

1.  installs the 1.7 version of `samtools` (via `apt-get`)
3.  runs `samtools` saving the output in a directory outside the container.

```
docker run --rm -v $HOME/data:/data elixir2
```
can be used to run the container

[Solution](https://github.com/ELIXIR-IIB-training/docker-advanced-course/solutions/1-4-02-samtools/Dockerfile)


# Exercise 3

Build an image (i.e. write the Dockerfile) that:

1.  downloads the version [1.9](https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2) of `samtools`
2.  compiles `samtools`
3.  runs `samtools` saving the output in a directory outside the container.

```
docker run --rm -v $HOME/data:/data elixir3
```
can be used to run the container

# Solutions Ex. 3

[Development version](https://github.com/ELIXIR-IIB-training/docker-advanced-course/solutions/1-4-03-samtools-build/Dockerfile)

[Production version](https://github.com/ELIXIR-IIB-training/docker-advanced-course/solutions/1-4-03-samtools-build/final/Dockerfile)

In production we want to minimize the *image size*, in development we want to minimize *runtime* (exploit the cache)


# Exercise 4

Build an image (i.e. write the Dockerfile) that:

1.  runs a version of `samtools` that has been stored and compiled outside the container (e.g. in `$HOME/code/`), saving the output in a directory outside the 3 container.
2.  find the best `docker run` invokation


# Solution Ex. 4

[Solution](https://github.com/ELIXIR-IIB-training/docker-advanced-course/solutions/1-4-04-samtools-external/Dockerfile)


# Installing programs

1.  Ubuntu/Debian packages [list](https://packages.ubuntu.com/bionic/) or `apt search`
2.  [Conda](https://conda.io) packages. [search](https://anaconda.org/) or `conda search`
3.  [Linuxbrew](http://linuxbrew.sh/). [List](http://formulae.brew.sh/) or `brew search`
3.  From specialized archives: e.g. `pip`
4.  Compile the program

# Ubuntu packages

*  Lots of packages ready `apt-get install ne`
*  Very robust
*  Additional packages with PPAs `add-apt-repository ppa:user/ppa-name`
   *  Not very useful for science

## Advantages

*  Safe and efficient
*  Easy to rebuild from source

## Cons

*  Sometimes outdated (Ubuntu LTS are released every 2 years)

# Conda packages

*  Relies on channels
   *  *base* with installation
   *  *bioconda*: bioinformatics programs
   *  *conda-forge*: misc programs
*  Not very robust/stable

## Advantages

*  Programs are usually the latest version

## Cons

*  Needs update to config files (`~/.bashrc`)
*  Weird interactions with system programs/libraries
*  Messes up with `$PATH` (e.g. shebang)

# Linuxbrew packages

*  Only one source of packages
*  Similar to conda
   *  fewer packages


# Exercise 5


Build an image (i.e. write the Dockerfile) that:

1.  uses `conda` to install the latest version of `samtools`
3.  runs `samtools` saving the output in a directory outside the container.

```
docker run --rm -v $HOME/data:/data elixir5
```
can be used to run the container

# Solution Ex. 5

[Solution](https://github.com/ELIXIR-IIB-training/docker-advanced-course/solutions/1-4-05-samtools-conda/Dockerfile)


