#First build the Dockerfile
docker build -t lsst-server .

#To run the docker container, you need to use the following command.
docker run -it --net=host --pid=host --name salOjb lsst-server

#To use salobj is necessary to add salobj to the PYTHONPATH, this can be done with:
source /home/docker/environment.env

#You can test an example CSC using:
cd /home/docker/
python3 testCSC.py
