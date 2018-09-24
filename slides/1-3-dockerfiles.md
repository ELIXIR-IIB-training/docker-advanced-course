---
title: Dockerfile
header-includes:
-  \lstset{basicstyle=\ttfamily,breaklines=false}
-  \lstset{backgroundcolor=\color{black!10},frame=TRBL, frameround=tttt}
-  \setmonofont{Ubuntu Mono}
---

# Dockefile: why?

A docker can be created by hand

* pull an image
* start a container
* modify the container
* commit the changes 

this is more or less the process for creating a reusable container *an Image*

# Dockerfile> why?

By *hand* is good for practicing or testing but is very bad for 

* reproducibility
* automation
* dependencies

# Dockerfile: why?

By *hand* is good for practicing or testing but is very bad for 

**reproducibility**: lost the history of the commands that create the final image

* automation

* dependencies

# Dockerfile: why?

By *hand* is good for practicing or testing but is very bad for 

* reproducibility

**automation**: images are lost because some disaster and eveything was on a local machine

* dependencies

# Dockerfile: why?

By *hand* is good for practicing or testing but is very bad for 

* reproducibility

* automation

**dependencies**: images are build from other images and something must be changed in the original image

# Dockerfile: what is it?

A simple text files with all the instructions for

* start (PULL) from a (public) Linux distribution
* install software
* configure the installation
* configure the container for running automatically

# Dockerfile: what is it?

The most minimal `Dockerfile`

```
FROM ubuntu:18.04
```

*Note* by convention `Dockerfile` is the name to use for the file containing the instructions.

# Dockefile: how to use it

A `Dockerfile` can be used for building a new image

```
 $ docker build -t Origin .
 Sending build context to Docker daemon  2.048kB
 Step 1/1 : FROM ubuntu:18.04
  ---> cd6d8154f1e1
  Successfully built cd6d8154f1e1
  Successfully tagged Origin:latest
```
A new image is created with the `sha256` `cd6d8154f1e1` called `Origin` and the version, in this case by default `Docker` assign the tag `latest`

# Dockerfile: FROM

Start from a Linux distribution or previous *installations*/images

```
FROM <image> [AS <name>]

FROM <image>[:<tag>] [AS <name>]

FROM <image>[@<digest>] [AS <name>]
```

# Dockerfile: LABEL
Metadata are useful in order to describe the image, making it more consumable by others

`LABEL <key>=<value> <key>=<value> <key>=<value> ...`
```
LABEL "com.example.vendor"="ACME Incorporated"
LABEL com.example.label-with-value="foo"
LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."

LABEL maintainer=”bonnal@ingm.org”
```
User is free to use any kind of `key=val` convention but the *reverse DNS* notation.


# Dockerfile: ENV

Environment variables can be set inside the container

```ENV <key> <value>
ENV <key>=<value> ...
```

```
ENV myName="John Doe" myDog=Rex\ The\ Dog \
    myCat=fluffy
```	
and
	
```
ENV myName John Doe
ENV myDog Rex The Dog
ENV myCat fluffy
```
these variable are available during the building process and when the container is running

# Dockerfile: injecting files

To fully customize the image, external files can be include. To achieve this `Docker` provides two different tools

* `ADD`
* `COPY`

# Dockerfile: ADD


```
ADD [--chown=<user>:<group>] <src>... <dest>
ADD [--chown=<user>:<group>] ["<src>",... "<dest>"]
```
* Digest URLs, download
* Unpack archives (identity, gzip, bzip2 or xz)
* Does not perform authentication

# Dockerfile: COPY

```
COPY [--chown=<user>:<group>] <src>... <dest>
COPY [--chown=<user>:<group>] ["<src>",... "<dest>"]
```
* Relative path outside of context does not work
* Works only with local files or directory
* Can copy files from source location to a previous build stage “FROM“
* NO URLs
* NO auto unpacking

# Dockerfile: SHELL

When commands must be run with a different shell

```
SHELL ["executable", "parameters"]
```

# Dockerfile: USER

Set the USER to use during when the containers run.
It also set the user for RUN, CMD, ENTRYPOINT following the declaration of USER

```
USER <user>[:<group>]
USER <UID>[:<GID>]
```

# Dockerfile: context

Context defines what is visible at the build time by Docker.
Data inside the `context` are copied in a temporary place where the building process is working. The building process can see only data in that temporary place. 

This process of `building the context` can take a lot of time if files are big and many.

Avoid:

* huge files
* temporary or working file
* backup 

in the context.

A lean `context` means quick build.
