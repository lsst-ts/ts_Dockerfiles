#First build the Dockerfile
docker build -t lsst-server .

#To run the docker container, you need to use the following command.
docker run -it --net=host --pid=host --name salOjb lsst-server