# CSC Development
## Template
The first step in developing a new CSC is to create the standard directory tree to store the source code. 
For that you can use the Template generator provided by DM which also provides templates for T&S code.

You can find the template generator in this link: https://github.com/lsst/templates

It already includes the possibility of generating lsst-ts code, setting up the directory tree to follow T&S standard and generates basic eups/scons config files (used for development).
Users can install it locally on their machines (works on MacOS).
You should run this on your development computer, where you want to store your code, not inside the container.

It is important to understand that development happens on your local computer, using your preferable development tools (PyCharm, Atom, emacs, vim, vi).
Docker will be used to generate the SAL libraries, to run unit tests and run the code.

## Pulling the development environment
While development happens on your local machine, docker allows you to easily start a fresh environment to build SAL libraries, run unit tests and the code.
The development container is currently updated with the latest version of the libraries (salobj, sal and xml). For help contact https://confluence.lsstcorp.org/display/~tribeiro.

Do pull the image, go on the command line and type:
```
docker pull lsstts/develop-env:20190610_sal3.10.0_salobj3.12.0
docker run -v <your_local_development_folder>:/home/saluser/develop -it lsstts/develop-env:20190610_sal3.10.0_salobj3.12.0
```
You can build SALPY libraries by typing `make_salpy_libs.py <name> [<name2>...]` which will build them and install them in a location where they are immediately usable (`ts_sal/lib` for the C++ library and `ts_sal/python` for the SALPY library).

On your command (`docker run`) the option `-v <your-local_development_folder>:/home/saluser/develop` will mount a folder on your computer inside the "develop" folder of the container.
This is how you enable docker to access the code you will be developing.

## Developing on your own local folder on Docker
To use your own local repository for ts_xml the suggested method is to use eups/setup to replace the repository used by the container by your own.
To do that, assuming you are working on ts_xml that is inside <your_local_development_folder>, and that was mounted inside the container do;
```
cd /home/saluser/develop/ts_xml
eups declare -r . ts_xml -t $USER
setup ts_xml -t $USER
```
Once you do that, the command make_salpy_libs.py will search your local ts_xml repo to build the topics.
You can develop the xml locally on your computer and build the sal libraries with make_salpy_lib.py and they will be available to use inside the container.

In case you want to fall back to the xml inside the container you just need to do:
```
setup ts_xml -t current
```
### Running scons and CSC unit tests
For unit tests that uses sal to run properly with scons you need to modify the file <repository_root>/tests/SConscript to have something like this:
```
# -*- python -*-
import os

from lsst.sconsUtils import env, scripts
scripts.BasicSConscript.tests(pyList=[])

for name in ("OSPL_URI", "OPENSPLICE_LOC"):
	val = os.environ.get(name)
	if val is not None:
		env.AppendENVPath(name, val)
```
What this does is to set the environment variable OSPL_URL and OPENSPLICE_LOC for the unit tests to run.
### Adding executables to your repository
You can add an executable script to your repository to initialize your CSC.
To do that, add the script to the directory <repository_root>/bin.src and add the following to the file <repository_root>/ups/<repository_name>.table
```
envPrepend(PATH, ${PRODUCT_DIR}/bin)
```
This way, when you setup your package it will add <repository_root>/bin to the $PATH environment variable and when you run scons, it will copy the scripts in <repository_root>/bin.src to <repository_root>/bin and make them executables.