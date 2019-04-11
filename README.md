## Docker Environment for salobj

#There are 2 versions of the docker file to use salobj. 
#1-no_lsst_stack: Doesn't use the lsst-stack
#2-with_lsst_stack: Uses the lsst-stack
#Either case should work the same

#A more updated version of docker is required, so to install use:
curl -fsSL https://get.docker.com/ | sh

1.- 
#The following instructions are for the Dockerfile in ./no_lsst_stack folder.
#First build the Dockerfile
#In ./no_lsst_stack
docker build -t salobj .

#To run the docker container, you need to use the following command.
docker run -it --net=host --name salobjImage salobj bash

#Setup the packages by running. This will build the Test topics, setup salobj and run unit tests.
source /home/lsst/environment.env

#You can test an example CSC using:
python3.6 testCSC.py

2.- 
#The following instructions are for the Dockerfile in ./with_lsst_stack folder.
#First build the Dockerfile
#In ./with_lsst_stack
docker build -t salobj .

#To run the docker container, you need to use the following command.
docker run -it --net=host --name salobjImage salobj bash

#Setup the packages by running. This will build the Test topics, setup salobj and run unit tests.
source /home/lsst/repos/salgenerate.sh

#You can test an example CSC using:
python3.6 testCSC.py

## Docker Environment for Active Optics System (AOS)

- **Build the Docker image**: Execute `docker build -t $tag_list .` under the aos_env directory. For example, `docker build -t lsst/aos:latest .`.

- **Run the Docker container**: Execute `docker run -it --net=host --rm $tag_list`. For example, `docker run -it --net=host --rm lsst/aos`. If we want to mount the local disk folder, execute `docker run -v $local_development_folder:/home/lsst/$mount_folder_path -it --net=host --rm $tag_list`. For example, `docker run -v /Users/ttsai/Documents/github:/home/lsst/develop -it --net=host --rm lsst/aos`.
