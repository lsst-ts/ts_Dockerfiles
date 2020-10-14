# LabVIEW Environment with VIPM Package Manager

## Overview

This Dockerfile and accompanying files are designed to create a Docker image to use for testing the Rubin observatory and CTIO LabVIEW-related software.

It creates an image based on the CentOS base image, and installs the LabVIEW, VIPM, Caraya unit test framework, and other test related dependencies.
The default user is **appuser**.

## Build Steps by DockerFile

To build this Docker image follow the steps below:

1. Download and unzip `vipm-2017-linux.tar.gz`. Make sure that the folder is named `vipm-2017-linux/` since this is the folder the Dockerfile will be looking for.

2. Copy the versions of LabVIEW that you expect to install onto the Docker container. For the examples shows below, I have two folders. These folders are named `LabVIEW2018SP1/` and `LabVIEW2020/`. I will use these names as examples for the commands that you can run.

3. Check the permission of `INSTALL` and `UNINSTALL` files in the LabVIEW directories. If you copy the files by GUI from the mount point, maybe they will not be executable. If not, do `chmod +x [file]` to update the permission. It is similar for the `vipm-2017-linux/` dicectory.

4. The next step has allows you to create 3 possible images. These different images can be created using the commands described below:

- To build a CentOS7 image with LabVIEW 2018 SP1 you can use a command such as the following:

```bash
docker build --build-arg CENTOS_VERSION=centos7 --build-arg LV_PATH=LabVIEW2018SP1 -t cagvm3.ctio.noao.edu:8082/centos7/labview2018sp1:latest .
```

- To build a CentOS7 image with LabVIEW 2020 you can use a command such as the following:

```bash
docker build --build-arg CENTOS_VERSION=centos7 --build-arg LV_PATH=LabVIEW2020 -t cagvm3.ctio.noao.edu:8082/centos7/labview2020:latest .
```

- To build a CentOS8 image with LabVIEW 2020 you can use a command such as the following:

```bash
docker build --build-arg CENTOS_VERSION=centos8 --build-arg LV_PATH=LabVIEW2020 -t cagvm3.ctio.noao.edu:8082/centos8/labview2020:latest .
```

## Manual Build Steps

Some step such as the installation of Caraya unit test framework needs to be done manually. It is noted that all the following steps need to be the `root`.

Install Caraya unit test framework via VIPM:

1. Run `vipm`.
2. Navigate to "Tools->Options->LabVIEW" click "verify".
3. In the LabVIEW window that pops up, navigate to "Tools->Options->VI Server"
4. Check mark the "TCP/IP" box and add the following to the "Machine Acess" list "localhost", "127.0.0.1", "*" without the quotes.
5. in VIPM navigate to "File->Open package File(s)", navigate to `/home/appuser/LabVIEW/` and double click `jki_rsc_toolkits_palette-1.1-1.ogp` to install it.
6. Within VIPM search for "Caraya Unit Test Framework" and install it.

Create the `.Xauthority` file for Xvnc plugin on CTIO Jenkins to use. Do the following:

```bash
echo -e 'taco12345\ntaco12345\nn' | vncserver :10
vncserver -kill :10
```

It it noted that the display ID may or may not be `:10`. You can use `vncserver -list` to check this.
