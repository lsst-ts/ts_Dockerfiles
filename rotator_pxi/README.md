# Software Environment of Rotator PXI Controller

## Overview

This Dockerfile tries to have the similar software environment in the rotator real-time controller. The NI PXIe-8840 controller is used. The Xenomai dual kernel is installed in the controller. The ipipe, EtherCAT, and HDF5 are installed as well.

## Difference with the PXI Controller

1. When installing the Linux kernel, the default configuration (`make defconfig`) is used instead of the customization of real-time contrroler. To do this, the user needs to use `make menuconfig` and enable the [parameters](doc/linuxConfig.md). The user can also copy the  existing `.config` file instead.
2. Because the docker container does not allow the `reboot`, the installed Linux kernel does not run actually.
3. While building the Xenomai dual kernel, the user needs to use `make menuconfig` and disable the [parametersDual](doc/linuxConfigDual.md).
4. The Xenomai dual kernel is not built. To do this on the PXI controller, the user needs to do the following in Linux kernel directory (`$core_patch=core-3.18.20-x86-9.patch` here):

```bash
make bzImage modules $core_patch
```

5. Default configuration is used for the Xenomai library. For the real PXI controller, the user needs to do:

```bash
$xenomai_dir/configure --with-core=cobalt --enable-smp -enable-pshared -host=i686-linux CFLAGS="-m32 -O2" LDFLAGS="m32"`
```

6. When build the EtherCAT in the PXI controller, the user needs to do (`$version=3.4` here):

```bash
./configure --enable-8139too=no --enable-generic=no --enable-e1000e=yes --enable-rtdm --with-xenomai-dir=/usr/xenomai --enable-cycles -with-e1000e-kernel=$version
```

7. Update the file `/etc/sysconfig/ethercat` to define the correct MAC address in the `MASTER0_DEVICE` entry.
8. Start the EtherCAT master service by:

```bash
/etc/init.d/ethercat start
```

## Library Paths

1. The Linux kernel is at `/boot`. The source is at `/home/linuxSrcDir/linux-$version`.
2. The Xenomai is at `/usr/xenomai`.
3. The EtherCAT is at `/opt/etherlab`.
4. The HDF5 is at `/usr/local/hdf5`.

## Tag List

- v0.1
  - linux-kernel: v3.18.25
  - xenomai: v3.0.1
  - ipipe-core: 3.18.20-x86-9.patch
  - ethercat: hg, v1.5.2
  - hdf5: v1.12.0
  - cmake
  - glib-devel
  - glib2-devel.x86_64
  - libtool
  - autoconf
  - automake
  - python-devel
