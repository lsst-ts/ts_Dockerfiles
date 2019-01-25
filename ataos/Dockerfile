FROM lsstsqre/centos:7-stackbase-devtoolset-6

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd --gid 1000 lsst
RUN adduser -u 1004 -m -g lsst -s /bin/bash saluser

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y --enablerepo=extras install epel-release \
  unzip \
  wget \
  git \
  dos2unix \
  tk \
  tk-devel \
  swig \
  ncurses-libs \
  xterm \
  xorg-x11-fonts-misc \
  java-1.8.0-openjdk-devel \
  boost-devel \
  boost-python \
  boost-python-devel \
  maven \
  which \
  gnome-terminal \
  mariadb \
  mariadb-devel \
  nano \
  emacs && \
  yum clean all

#WORKDIR /home/saluser/repos
#RUN git clone https://github.com/lsst-ts/ts_ataos.git
#
#WORKDIR /home/saluser/repos/ts_ataos
#RUN git fetch && git checkout "origin/tickets/DM-17303" -b "tickets/DM-17303"
#
#WORKDIR /home/saluser
#
#WORKDIR /home/saluser/repos/ts_ataos
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_salobj -t $USER && \
#    setup ts_sal -t $USER && \
#    make_salpy_libs.py ATAOS ATMCS ATPneumatics ATHexapod ATCamera && \
#    eups declare -r . ts_ataos -t $USER && setup ts_ataos -t $USER && \
#    scons
#
#WORKDIR /home/saluser/
#
#ENTRYPOINT ["/bin/bash", "--"]
#CMD ["/home/saluser/.setup.sh"]
