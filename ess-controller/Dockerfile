# Generic SAL configuration
FROM centos:centos7

RUN yum install -y epel-release && \
    yum update -y && \
    yum install -y git gcc gcc-c++ make openssl-devel bzip2-devel libffi-devel ncurses-libs xterm \
      xorg-x11-fonts-misc vim bash-completion bash-completion-extras wget libgphoto2-devel libftdi \
      libftdi-devel iproute minicom && \
    yum clean all

COPY minirc.dfl /etc/minirc.dfl

RUN groupadd -g 70014 docker
RUN adduser -G wheel,docker saluser
ENV CONDA_DIR=/home/saluser

USER saluser
WORKDIR /home/saluser
ENV ARCH=aarch64
COPY start.sh /home/saluser/start.sh

RUN mkdir -p ${CONDA_DIR} && \
    curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${ARCH}.sh -o miniforge.sh && \
    chmod +x miniforge.sh && ./miniforge.sh -b -p ${CONDA_DIR}/miniforge && \
    source ${CONDA_DIR}/miniforge/bin/activate && \
    conda config --add channels lsstts && \
    conda install -y python=3.8 && \
    conda install -y cython && \
    conda install wheel && \
    conda install conda-verify && \
    conda install -y conda-build anaconda-client setuptools_scm && \
    conda install -y numpy=1.20 astropy=4.1 && \
    conda install -y ts-ddsconfig ts-ess-controller=0.4.4 && \
    pip install asyncio pyserial pylibftdi pyftdi jsonschema pyyaml

RUN echo source ${CONDA_DIR}/miniforge/bin/activate >> /home/saluser/.bashrc

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/start.sh"]
