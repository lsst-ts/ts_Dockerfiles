========================
Building this Dockerfile
========================

1) In order to create this docker image locally you must first copy a folder named "TeknikerSoftware" from Chile IT Network Drive. You can obtain access to the drive by asking an IT member from Chile. Once you have access navigate to "TSS-Share" and copy over the "TMA/TeknikerSoftware" folder into the root directory of this repo. You may nay rebuild th Docker image, remember not to publicly share the contents of this folder. The "TeknikerSoftware" folder has been added to the .gitignore.

2) Now, you must have a way to open the GUI applications on your machine from the docker containers. The following is what I did to get the LabVIEW windows working on my MacOS laptop. 

- Install xquartz https://www.xquartz.org/
- Do `docker build -t tma_simulations .`
- Do `export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')`
- Do `xhost + $IP`
- Then run your container like this `docker run -it --net host -e DISPLAY=$IP:0 -v /tmp/.x11-unix:/tmp/.x11-unix tma_simulations:latest`
- Once inside the container, you should be able to do `labview` or `labview64` and see a labview window appear. Cool!

3) Now you can begin with the VIPM complete the EUI installation by entering the image, and installing the required VIPM (VI Package Manager - a tool for installing LabVIEW modules) modules. 