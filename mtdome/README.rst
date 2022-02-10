=====================
About this Dockerfile
=====================

This Dockerfile is intended to be used for testing the MTDome CSC at the summit as long as the EIE network has not been connected to the Rubin Observatory network yet.
It will start the CSC and Jupyter Lab so the CSC can be commanded.
It also contains a basic notebook that can be used to test the dome rotation.

Run the docker container as follows:

docker run -it --name ts-mtdome -p 127.0.0.1:8888:8888 lsstts/ts-mtdome:c0024.000

Then point your browser at:

http://127.0.0.1:8888/lab
