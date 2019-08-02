# Using Conda Develop Env
Pull down the image using the following command.
```
docker run -it lsstts/develop-env-conda
```
This image contains only the necessary packages for SAL and opensplice.
It only contains a base miniconda environment.
To use the image, activate the base conda environment by typing the following.
```
source ~/miniconda3/bin/activate
```
In front of your shell, you should see `(base)`, this denotes that you have activated the base conda environment.
The image by default installs python 3.6.
Typically, you don't do work in the base/root environment of conda, except in special cases where certain packages need to be installed.
You'll do the work in different conda environment that you can activate from inside the base conda environment.
To create a new environment, type the following in your shell.
```
conda create -n name_of_environment python={version}
```
Where `-n` is the name of the environment and version is the version of python that you wish to install.
You can install other packages as well using this syntax.
```
... numpy=1.17
```
Once the new environment is created, you can activate by typing the following into your shell.
```
conda activate name_of_environment
```
Once inside the new environment, you can install any conda packages that you like.
```
conda install gcc numpy
```
Packages are found by looking through channels(which you can think of as organizations) which contain various packages.
A nice resource to look for useful packages is the conda-forge channels, a community maintained collection of useful libraries and packages.
LSST-TSSW has their own channel found [here](https://anaconda.org/lsstts/).
Right now, it only has one package which is ts-salobj.
To install ts-salobj, we need to tell conda where to find it, type the following into your shell.
```
conda install -c lsstts ts-salobj
```
The `-c` takes the name of a channel as an argument and overrides the channel list found in the configuration.
Activate SAL using the following command.
```
source ~/repos/ts_sal/setup.env
```
You can then build your libraries using the following steps.
Follow the csc_development instructions.
This assumes that you have a develop folder mounted that contains ts_xml and ts_idl.
```
# with a sourced setup.env
cd ~/repos/ts_sal/bin.src
# SALPY
python make_salpy_libs.py Test
# PyDDS
python make_idl_libs.py Test
```
