#There are 2 versions of the docker file to use salobj. 
#1-no_lsst_stack: Doesn't use the lsst-stack
#2-with_lsst_stack: Uses the lsst-stack
#Either case should work the same

#The following instructions are for the Dockerfile in ./no_lsst_stack folder.
#A more updated version of docker is required, so to install use:
curl -fsSL https://get.docker.com/ | sh

#First build the Dockerfile
docker build -t salobj .

#To run the docker container, you need to use the following command.
docker run -it --net=host --name salobjImage salobj bash

#Setup the packages by running. This will build the Test topics, setup salobj and run unit tests.
source /home/lsst/environment.env

#You can test an example CSC using:
python3.5 testCSC.py
