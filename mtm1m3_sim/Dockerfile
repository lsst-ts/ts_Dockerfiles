FROM lsstts/develop-env:b68

USER root
RUN yum -y install boost-devel

USER saluser

RUN cd /home/saluser/repos/ts_sal && git checkout develop && git pull

WORKDIR /home/saluser/repos/ts_sal
RUN source setup.env \
    && cp ../ts_xml/sal_interfaces/*.xml ../ts_xml/sal_interfaces/MTM1M3/*.xml ../ts_xml/sal_interfaces/MTMount/*.xml test \
    && cd test \
    && salgenerator MTMount generate cpp \
    && salgenerator MTM1M3 generate cpp

RUN cd /home/saluser/repos && git clone -b v1.7 https://github.com/lsst-ts/ts_m1m3support

WORKDIR /home/saluser/repos
RUN source ts_sal/setup.env \
    && cd ts_m1m3support \
    && make SIMULATOR=1

COPY startup.sh .

SHELL ["/bin/bash", "-lc"]
ENTRYPOINT ["sh","./startup.sh"]
