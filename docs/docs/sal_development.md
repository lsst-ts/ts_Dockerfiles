# SAL Development

Author|
------|
Russell Owen|

!!! note
	These instructions are useful for those developing T&S Software with Docker.

This is my personal take on the best way for software developers to run the lsstts/develop-env:develop Docker container.
My emphasis is keeping all code and generated files on your own disk, so changes persist between invocations of the Docker container.
This lets you pick and choose which version of which package you want to use, upgrade whenever you like, and use your favorite tools for editing code and managing git.
The down side is you have to build all the telescope and site packages that you want to use yourself.
This is not intended for deployment!

* Install Docker, start it running and log into your Docker account.
* `docker pull lsstts/develop-env:20190610-sal3.10.0_salobj3.12.0`
* Make sure you have a single directory that contains git clones of all of the Telescope and Site github repositories that you use.
	This should include ts_sal, ts_xml and ts_salobj at a minimum, ts_scriptqueue, ts_standardscripts and ts_externalscripts are also likely to be useful, plus any other packages you are workingon or using.
	I will refer to this directory as `<your_tsrepos>`.
* Create a directory tree `<your_tsrepos>/docker/develop-env/` (in other words `mkdir <your_tsrepos>/docker` and then `mkdir <your_tsrepos/docker/develop-env>`).
	Having the hierarchy makes it easy to add fixup scripts for other docker containers.
* Put the attached https://confluence.lsstcorp.org/download/attachments/102469237/setup.sh script into `<your_tsrepos>/docker/develop-env/`
* Edit the setup.sh file to setup the packages you want.
	Sections you need to edit are marked with *****.
	Note that you should declare every package you want to use, whether you are using your own copy or the copy built into the Docker image.
* Put the attached https://confluence.lsstcorp.org/download/attachments/102469237/setup.env file into `<your_tsrepos>/docker/develop-env/`
* You should not need to edit setup.env but it is best if you look it over.
* Put the following into your `~/.bashrc` file so you can easily run the lsstts/develop-env Docker container.
	There is nothing magic about `--name develop-env`, and indeed if you want to have more than one develop-env container running at the same time you must assign a unique name to each one.
	```
	alias rundevelop="docker run -it --rm --name develop-env \
        -v $HOME/.config:/home/saluser/.config \
        -v <your_tsrepos>:/home/saluser/tsrepos \
        lsstts/develop-env:develop \
        /home/saluser/tsrepos/docker/develop-env/setup.sh"
	```
* Sharing `~/.config` shares your .config dir so your Docker container can find your standard flake8 config.
	I have attached my https://confluence.lsstcorp.org/download/attachments/102469237/flake8 file, which matches LSST standards.
	Warning: it will download with an extension ".dms" which you should remove, so the final name is just "flake8".
* To get started with your Docker container, in a fresh terminal session type the following:
	```
	$ rundevelop
    $ cd tsrepos/ts_...
    $ scons
	```

This will build Test and Script SALPY libraries and run the unit tests.
Note that having scons build SALPY libraries is unique to ts_sal (because proving that libraries can be built is an important test in its own right).
For other ts packages you have to build the libraries you want before running unit tests.

* To build the SALPY libraries for any other package, use the `make_salpy_libs.py` command.
	This puts the libraries where the ts_packages can find them.
	For example make_salpy_libs ScriptQueue ATMCS ATDome ...
* Build the SALPY libraries for any other package(s) you want to use.
	You only have to do this once, unless a package changes.
	* Check out whatever version of ts_xml you want to use (you can do this outside or inside the Docker container; I prefer outside).
	* `make_salpy_libs.py <name1> <name2>... e.g. make_salpy_libs ScriptQueue ATMCS ATDome`
* Build all the packages you depend on (this is where using lsstts/develop-env with the included packages is a win, sicne they're already built).
	For each package:
	* Check out the version you want to build (again you can do this inside or outside the Docker container)
	* In your Docker container:
		* `cd tsrepos/ts_<name>`
		* `# setup -r .` # not necessary if you declared and setup the package in docker/develop-env/setup.sh
		* `scons`
* At this point you should be good to go.
	You can run any of your packages.
	And if you quit Docker and start it again, all the SALPY libraries you built and all the code you checked out will be in the same state it was.
	Your packages will still be built.
* To work on a package you can do all your editing and git with your favorite tools outside your Docker container.
	Just use the Docker container to build the software and run unit tests.