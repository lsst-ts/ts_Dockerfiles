# Installing docker on CentOS
## Docker Install via Docker's repository
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

!!! failure
	If you receive the following error during this step check to make sure that SELinux is disabled.

	```
	Unable to find image 'hello-world:latest' locally
	latest: Pulling from library/hello-world
	1b930d010525: Pull complete
	Digest: sha256:41a65640635299bab090f783209c1e3a3f11934cf7756b09cb2f1e02147c6ed8
	Status: Downloaded newer image for hello-world:latest
	docker: Error response from daemon: OCI runtime create failed: container_linux.go:345: starting container process caused "process_linux.go:430: container init caused \"write /proc/self/attr/keycreate: permission denied\"": unknown.

	```
	You can check if it is disabled by doing `sestatus`

	```
	aheyer ~ 09:52:42  sestatus
	SELinux status:                 enabled
	SELinuxfs mount:                /sys/fs/selinux
	SELinux root directory:         /etc/selinux
	Loaded policy name:             targeted
	Current mode:                   enforcing
	Mode from config file:          enforcing
	Policy MLS status:              enabled
	Policy deny_unknown status:     allowed
	Max kernel policy version:      31
	Post install
	```

	If it is enforced you can disable it by doing `sudo setenforce 0`, then to keep the changes permanently edit `etc/selinux/config` to look like the following

	```
	# This file controls the state of SELinux on the system.
	# SELINUX= can take one of these three values:
	#     enforcing - SELinux security policy is enforced.
	#     permissive - SELinux prints warnings instead of enforcing.
	#     disabled - No SELinux policy is loaded.
	SELINUX=permissive
	# SELINUXTYPE= can take one of three two values:
	#     targeted - Targeted processes are protected,
	#     minimum - Modification of targeted policy. Only selected processes are protected.
	#     mls - Multi Level Security protection.
	SELINUXTYPE=targeted
	```

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
## Configure Docker with the overlay2 storage driver
### Prerequisites
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

### Configuration
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