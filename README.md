# Docker Environment for salobj

There are 2 versions of the docker file to use salobj. 

1. no_lsst_stack: Doesn't use the lsst-stack
2. with_lsst_stack: Uses the lsst-stack

Due to some use of ARG before FROM, Docker >= 17.06 is needed. Either update Docker through your packaging system, or with:

```bash
curl -fsSL https://get.docker.com/ | sh
```

## Building salobj

Either:

```bash
make no_lsst_stack
```

or

```bash
make with_lsst_stack
```

To run the salobj container, do:

```bash
docker run -it --net=host --name salobjImage salobj bash
```

Setup the packages by running in the container:

```bash
source /home/lsst/environment.env
```

or (for with_lsst_stack) by:

```bash
source /home/lsst/repos/salgenerate.sh
```

## Documentation

To install prerequisites:

```bash
cd docs
pip install -r requirements.txt
```

To build and serve the documentation:

```bash
cd docs
mkdocs serve
```

