---
title: Advanced Docker Course
header-includes:
-  \lstset{basicstyle=\ttfamily,breaklines=false}
-  \lstset{backgroundcolor=\color{black!10},frame=TRBL, frameround=tttt}
-  \setmonofont{Ubuntu Mono}
---

# Add the Storage details
TODO

# Data in Docker

We are in a containerized world.

Everything is separated.

How do we shared/access data ?

# Data in Docker

Docker has 3 options

* Volumes

* Bind Mounts

* tmpfs mount

# Data in Docker

![Docker & Data](img/docker-080-054.jpg)

# Data in Docker

## Volumes

* Managed directly by Docker
* Saved in `/var/lib/docker/volumes/` on the host
* System processes can not access data outside Docker
* Recommended by Docker to store data in Docker

# Data in Docker
## Volumes

* User can create its own volumes or instruct Docker to create them when required by the containers or services
* The container see the volume as a directory and the user define the name
* Docker guarantees isolation from the host machine
* A volume can be mounted by many containers at the same time
* If not used it is not destroyed, the user must remove the volume explicitly
* The user can name a volume or Docker create a random name automatically
* A volume can be an *object* in the cloud, the user must use a proper *driver*
* Avoid to increase the size of the container

# Data in Docker

## Bind mounts

* Managed directly by the host OS
* Saved in `/in/your/path/` on the host OS
* System processes or Docker containers can access to the data
* It is possible to override important files or directory on the host OS

# Data in Docker

## Bind mounts

* Files and directory from the host are mounted inside the container at runtime
* Require the target's full path on the host machine
* On demand creation inside the container
* Very performant
* Rely on the host filesystem
* From inside the contianer the user has full access to the filesystem: read/write
* Read/Write from outside the Docker container

# Data in Docker

Expose a *Volume* or *Bind Mount* into the container
```
---volume
```
Docker handles the different betweeen *Volume* and *Bind Mount* from the command line

# Data in Docker

In memory storage
```
---tmpfs
```
This is useful for ephemeral storage required by your software


# Data in Docker
## When use What

| Volume | Bind mount |
|--------|------------|
| Sharing data among containers | Sharing configuration to containers|
| The host lacks a directory structure | Sharing source code and build products |
| Data can not be stored locally (cloud) | Stable direcotry and file structures shared w/ containers|
