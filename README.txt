#First build the Dockerfile
docker build -t lsst-server .

#To run the docker container, you need to use the following command.
docker run -it --net=host --pid=host --name salOjb lsst-server

#Setup the packages by running. This will build the Test topics, setup salobj and run unit tests.
source /home/docker/salgenerate.sh

#You can test an example CSC using:
cd /home/docker/
python3 testCSC.py
