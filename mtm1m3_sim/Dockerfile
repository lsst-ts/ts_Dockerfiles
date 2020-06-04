FROM lsstts/develop-env:b76 as lsstts-cpp-dev

USER root
RUN yum -y install catch-devel boost169-devel

USER saluser

WORKDIR /home/saluser/repos/ts_sal
RUN source setup.env \
    && git checkout develop \
    && cp ../ts_xml/sal_interfaces/*.xml ../ts_xml/sal_interfaces/MTM1M3/*.xml ../ts_xml/sal_interfaces/MTMount/*.xml test \
    && cd test \
    && salgenerator MTMount generate cpp \
    && salgenerator MTM1M3 generate cpp

USER root
RUN chmod a+rwX -R /home/saluser/
USER saluser

FROM lsstts-cpp-dev

ARG M1M3_BRANCH=v1.7

WORKDIR /home/saluser/repos

RUN umask 0 && git clone --branch $M1M3_BRANCH  https://github.com/lsst-ts/ts_m1m3support

RUN source ts_sal/setup.env \
    && cd ts_m1m3support \
    && make SIMULATOR=1

COPY startup.sh .

SHELL ["/bin/bash", "-lc"]
ENTRYPOINT [""]
CMD ["./startup.sh"]
