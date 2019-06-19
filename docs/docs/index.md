# ts_Dockerfiles
Docker is a containerization application.
This repo is where TSSW Docker related software is contained.
## Installing docker on CentOS
### Docker Install via Docker's repository
Install required packages:
```
$ sudo yum install -y yum-utils
```
Set up the stable repository:
```
$ sudo yum-config-manager \
-- add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
```
Install the latest version of Docker CE and containerd:
```
$ sudo yum install docker-ce docker-ce-cli containerd.io
```
Start Docker (Docker is installed but not started):
```
$ sudo systemctl start docker
```
Verify that Docker CE is installed correctly by running the hello-world image.
```
$ sudo docker run hello-world
```
Post install
Create the docker group:
```
$ sudo groupadd docker
```
Add your user to the docker group:
```
$ sudo usermod -aG docker $USER
```
Log out and log back in so that your group membership is re-evaluated.
if testing on a virtual machine, it may be necessary to restart the virtual machine for changes to effect.
Verify that you can run docker commands without sudo:
```
$ docker run hello-world
```
### Configure Docker with the overlay2 storage driver
#### Prerequisites
Verify your CentOS is using version 3.10.0-514 of the Linux kernel or higher:
```
$ uname -s -r
```
Determine filesystem type:
```
$ df -TH /home
```
if filesystem is xfs:
Verify that the ftype option is set to 1.
```
$ xfs_info /home
```
If ftype is set to 0, then format the xfs filesystem correctly, use the flag -n ftype=1
The overlay2 driver is supported on xfs backing filesystems, but only with d\_type=true enabled.
d\_type means directory entry type; used by Linux kernel to describe the information of a directory on the filesystem
Easier option, if available, is to configure Docker to point to an ext4 mounted filesystem.

!!! note
    * You may format the filesystem and mount it into /var/lib/docker (the default docker daemon (root) dir) or with a name of your liking. 

If filesystem is ext4, nothing more to do.

#### Configuration
Run the following to check the "Storage driver" property
```
$ docker system info | grep "Storage Driver"
```
If not overlay2, perform the following steps:

Stop Docker:
```
$ sudo systemctl stop docker
```
Edit /etc/docker/daemon.json.
If it does not yet exist, create it.
Assuming that the file was empty, add the following contents:
```
{
	"storage-driver": "overlay2"
}
```
Start Docker:
```
$ sudo systemctl start docker
```
Verify that the daemon is using the overlay2 storage driver.
Use the docker info command and look for Storage Driver and Backing filesystem:
```
$ docker info
	e.g. xfs file system, default Docker Root Dir
	
		Containers: 0
		Images: 0
		Storage Driver: overlay2
		Backing Filesystem: xfs
		Supports d_type: true
		Native Overlay Diff: true
		<output truncated>
		Docker Root Dir: /var/lib/docker
		<output truncated>
```
Run the following to check the your user filesystem memory allocation:
```
$ df -TH /home
	e.g.
		filesystem Type Size Used Avail Use% Mounted on
		/dev/mapper/centos_jormungand-home xfs 298G 56G 242G 19% /home
	e.g.
		Filesystem Type Size Used Avail Use% Mounted on
		/dev/mapper/centos_kraken-root ext4 5.0T 5.0G 4.8T 1% /
```
If you feel it's not enough, then you may wish to change the default docker root dir as follows:
Stop Docker:
```
$ sudo systemctl stop docker
```
If necessary, copy the contents of the docker root dir (by default:/var/lib/docker) to a temporary location:
```
$ cp -au /var/lib/docker /var/lib/docker.bk
```
Add the new path to /etc/docker/daemon.json as follows:
```
{
	"data-root":"/new/data/root/path"
}
e.g.
	{
		"data-root":"/home2/docker-base/docker"
	}
```
Start Docker:
```
$ sudo systemctl start docker
```
Verify that the daemon is using the overlay2 storage driver.
Use the docker info command and look for Storage Driver and Backing filesystem:
```
$ docker info
	e.g. ext4 filesystem, non-default Docker Root Dir
		Containers: 0
		Images: 0
		Storage Driver: overlay2
		Backing Filesystem: extfs
		Supports d_type: true
		Native Overlay Diff: true
		<output truncated>
		Docker Root Dir:/home2/docker-base/docker
		<output_truncated>
```

Writing dockerfiles are documented by the <https://docs.docker.com/engine/reference/builder/>.
## Organization
```
.
├── aos_aoclc
│   ├── Dockerfile
│   └── README.md
├── aos_env
│   ├── Dockerfile
│   └── README.md
├── aos_sal
│   ├── Dockerfile
│   └── README.md
├── ataos
│   ├── Dockerfile
│   └── setup.sh
├── at_dome_sim
│   ├── Dockerfile
│   └── setup.sh
├── at_dome_trajectory_sim
│   ├── Dockerfile
│   └── setup.sh
├── at_hexapod
│   ├── Dockerfile
│   └── setup.sh
├── at_mcs_sim
│   ├── Dockerfile
│   └── setup.sh
├── at_pneumatics_sim
│   ├── Dockerfile
│   └── setup.sh
├── atspectrograph
│   ├── Dockerfile
│   └── setup.sh
├── Compose
│   ├── atptg_atmcs_integration
│   │   └── docker-compose.yml
│   ├── lab_jupyter_servers
│   │   ├── atdiag03_notebook_config.py
│   │   ├── atdiag03_setup.sh
│   │   ├── atdiag04_notebook_config.py
│   │   ├── atdiag04_setup.sh
│   │   ├── atdiag05_notebook_config.py
│   │   ├── atdiag05_setup.sh
│   │   └── docker-compose.yml
│   └── Simulators
│       ├── docker-compose.yaml
│       ├── docker_log.log
│       ├── README.md
│       └── startJupyter.sh
├── develop-env
│   ├── develop_py36
│   │   ├── Dockerfile
│   │   ├── lsst-ts.repo
│   │   └── setup.sh
│   ├── develop_py37
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── latest
│   │   ├── Dockerfile
│   │   └── setup.sh
│   └── light
│       ├── Dockerfile
│       └── lsst-ts.repo
├── dm-test
│   ├── Devel
│   │   ├── Dockerfile
│   │   ├── environment.env
│   │   ├── README.txt
│   │   ├── requirements.txt
│   │   ├── salgenerate.sh
│   │   └── startup.sh
│   ├── EFD
│   │   ├── create-tables.sh
│   │   ├── Dockerfile
│   │   ├── environment.env
│   │   ├── requirements.txt
│   │   └── salgenerate.sh
│   └── MariaDB
│       ├── Dockerfile
│       └── README
├── docs
│   ├── docs
│   │   └── index.md
│   └── mkdocs.yml
├── efd
│   ├── Dockerfile
│   ├── kafka
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── my.cfg
│   └── writers
│       ├── Dockerfile
│       └── setup.sh
├── efd_mariadb
│   ├── Dockerfile
│   └── README
├── efd_writers
│   └── Dockerfile
├── electrometer
│   ├── Dockerfile
│   ├── Electrometer
│   │   ├── docker-compose.yaml
│   │   ├── mainSetup.yaml
│   │   ├── startCSC.sh
│   │   └── startGUI.sh
│   ├── Electrometer.zip
│   └── setup.sh
├── environment
│   ├── Dockerfile
│   └── setup.sh
├── labview
│   ├── cintools.tar
│   └── Dockerfile
├── monochromator
│   ├── Dockerfile
│   └── setup.sh
├── mtaos_dev
│   ├── Dockerfile
│   └── README.md
├── mtaos_sim
│   ├── Dockerfile
│   └── README.md
├── mtcamerahexapod_sim
│   ├── Dockerfile
│   ├── mtcamerahexapod_csc.py
│   └── README.md
├── mtm1m3_sim
│   ├── Dockerfile
│   └── README.md
├── mtm2hexapod_sim
│   ├── Dockerfile
│   ├── mtm2hexapod_csc.py
│   └── README.md
├── mtm2_sim
│   ├── Dockerfile
│   ├── mtm2_csc.py
│   └── README.md
├── no_lsst_stack
│   ├── Dockerfile
│   ├── environment.env
│   ├── README.txt
│   ├── requirements.txt
│   ├── salgenerate.sh
│   └── startup.sh
├── pointing_component
│   ├── Dockerfile
│   ├── Dockerfile_withstack
│   ├── gui
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── known_hosts
│   ├── README
│   ├── sal3.9_dev
│   │   ├── Dockerfile
│   │   ├── known_hosts
│   │   └── setup.sh
│   ├── sal3.9_rpm
│   │   ├── Dockerfile
│   │   ├── known_hosts
│   │   ├── lsst-ts.repo
│   │   └── setup.sh
│   └── setup.sh
├── pointing_qa
│   └── Dockerfile
├── ptg
│   ├── Dockerfile
│   ├── README
│   ├── requirements.txt
│   └── run.sh
├── queue-env
│   ├── Dockerfile
│   ├── setup_and_build.sh
│   └── setup.sh
├── queue-env-py37
│   ├── Dockerfile
│   ├── setup_and_build.sh
│   └── setup.sh
├── queue-rpm
│   ├── Dockerfile
│   ├── lsst-ts.repo
│   └── setup.sh
├── README.md
├── robot
│   ├── bash_profile
│   ├── Dockerfile
│   ├── README
│   └── Test_Vars.txt
├── robotsal
│   ├── Dockerfile
│   ├── README
│   └── start.sh
├── simulation_tests
│   ├── atptgatmcsintegration.py
│   ├── Dockerfile
│   └── dometrajectorymcs.py
├── tunable_laser
│   ├── Dockerfile
│   ├── load_laser.sh
│   └── README.md
└── with_lsst_stack
    ├── Dockerfile
    ├── environment.env
    ├── requirements.txt
    ├── salgenerate.sh
    └── startup.sh
```
Our directory structure is as follows.
Folders denote the particular docker container typically a CSC but also include auxiliary containers such as for the EFD and the like.
Inside the folders are the docker files, this allows for easier development practice of making changes to interelated containers.
The Compose directory contains the compose files neccessary for bringing up multiple containers.
The Simulators directory contains the auxtel simulators.
The tagging of docker container for python CSCs is still up for debate.
Here's a list of potential options.

1. cscversion\_salversion\_salobjversion
