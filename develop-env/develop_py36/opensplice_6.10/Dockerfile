FROM lsstts/develop-env:20190610_sal3.10.0_salobj3.12.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

COPY opensplice10.2.tgz /opt

USER root

WORKDIR /opt

RUN tar zxvf opensplice10.2.tgz

RUN yum install -y mesa-libGLU*.i686 mesa-libGLU*.x86_64

RUN rm /opt/OpenSpliceDDS/V6.10.2/HDE/x86_64.linux/etc/opensplice6.10-10.0.100.1LK12619.lic
RUN rm /opt/OpenSpliceDDS/V6.10.2/HDE/x86_64.linux/etc/opensplice6.10.LK12616.lic
RUN rm /opt/opensplice10.2.tgz

USER saluser

ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.2/HDE/x86_64.linux

WORKDIR /home/saluser
