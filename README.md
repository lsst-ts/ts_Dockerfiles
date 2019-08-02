## Docker Environment for salobj

There are 2 versions of the docker file to use salobj.\
&nbsp;&nbsp;&nbsp;&nbsp; i. no_lsst_stack: Doesn't use the lsst-stack\
&nbsp;&nbsp;&nbsp;      ii. with_lsst_stack: Uses the lsst-stack\
Either case should work the same

To get the latest installation of docker, you can follow instructions at this link:
[Installing docker on CentOS](https://confluence.lsstcorp.org/display/LTS/Installing+docker+on+CentOS)

1\. **The following instructions are for the Dockerfile in ./no_lsst_stack folder.**
   - First build the Dockerfile in ./no_lsst_stack:
     > docker build -t salobj .

   - To run the docker container, you need to use the following command:
     > docker run -it --net=host --name salobjImage salobj bash

   - Setup the packages by running:
     > source /home/lsst/environment.env

     This will build the Test topics, setup salobj and run unit tests.

   - You can test an example CSC using:
     > python3.6 testCSC.py

2\. **The following instructions are for the Dockerfile in ./with_lsst_stack folder.**
   - First build the Dockerfile in ./with_lsst_stack:
     > docker build -t salobj .

   - To run the docker container, you need to use the following command:
     > docker run -it --net=host --name salobjImage salobj bash

   - Setup the packages by running:
     > source /home/lsst/repos/salgenerate.sh

     This will build the Test topics, setup salobj and run unit tests.

   - You can test an example CSC using:
     > python3.6 testCSC.py

***

## Docker Environment for Active Optics System (AOS)

1\. **Build the Docker image.**
   - Execute the following under the aos_env directory:
     > `docker build -t $tag_list .`

     For example:
     > `docker build -t lsst/aos:latest .`.

2\. **Run the Docker container.**
   - Execute:
     > `docker run -it --net=host --rm $tag_list`.

     For example:
     > `docker run -it --net=host --rm lsst/aos`.

   - If we want to mount the local disk folder, execute:
     > `docker run -v $local_development_folder:/home/lsst/$mount_folder_path -it --net=host --rm $tag_list`.

     For example:
     > `docker run -v /Users/ttsai/Documents/github:/home/lsst/develop -it --net=host --rm lsst/aos`.

## Documentation
Installing requirements.
```
cd docs
pip install -r requirements.txt
```
Building and serving documentation.
```
cd docs
mkdocs serve
```

