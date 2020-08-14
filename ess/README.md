# ESS

Be patient when these Docker images are building. They are based on CentOS 7 and both updates of the installed packages and new packages will be downloaded and installed. Then Python 3.7 is built and several Python modules get installed.

The Docker images are intended to run on a Raspberry Pi 3B+ or 4. When running a container for the image, a Raspberry Pi with more memory than 1 Gb will give a better performance. Choose the armv7l or aarch64 Dockerfile depending on which OS architecture you are running on the Raspberry Pi.