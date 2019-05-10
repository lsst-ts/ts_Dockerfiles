FROM centos:centos7

LABEL author="Andres Anania <aanania@lsst.org>"

ENV LSST_KAFKA_BROKERS=localhost
ENV LSST_EFD_HOST=localhost

RUN groupadd lsst
RUN useradd -G lsst saluser

RUN mkdir -p /opt/lsst
RUN mkdir -p /opt/OpenSpliceDDS
	
RUN yum -y install https://project.lsst.org/ts/lsstrepo/OpenSpliceDDS-6.9.0-1.x86_64.rpm \
	https://project.lsst.org/ts/lsstrepo/ts_EFDruntime-3.9.0-690.el7.centos.x86_64.rpm

RUN yum -y install mysql

# Next commands needs to be removed once the dependencies are added to the package
RUN sed -i "s|LD_LIBRARY_PATH=\${SAL_WORK_DIR}/lib:\${SAL_HOME}/lib|LD_LIBRARY_PATH=\${SAL_WORK_DIR}/lib:\${LSST_SDK_INSTALL}/lib |g" /opt/lsst/ts_sal/setupEFD.env
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LSST_SDK_INSTALL}/lib
# RUN yum -y install mariadb-devel \
# 	librdkafka
# Until here

RUN chown -R saluser:lsst /opt/lsst
RUN chown -R saluser:lsst /opt/OpenSpliceDDS

USER saluser