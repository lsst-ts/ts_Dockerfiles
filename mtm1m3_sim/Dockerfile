FROM lsstts/develop-env:latest as lsstts-cpp-dev

USER root
RUN yum -y install catch-devel boost169-devel make readline-devel

USER saluser

WORKDIR /home/saluser/repos/ts_xml
RUN git checkout develop && git pull

WORKDIR /home/saluser
RUN source .setup.sh \
    && cd repos/ts_sal \
    && cp ../ts_xml/sal_interfaces/*.xml ../ts_xml/sal_interfaces/MTM1M3/*.xml ../ts_xml/sal_interfaces/MTMount/*.xml test \
    && cd test \
    && salgenerator generate cpp MTMount \
    && salgenerator generate cpp MTM1M3

USER root
RUN chmod a+rwX -R /home/saluser/
USER saluser

FROM lsstts-cpp-dev

ARG M1M3_BRANCH=develop

RUN cd repos && umask 0 && git clone --branch $M1M3_BRANCH  https://github.com/lsst-ts/ts_m1m3support

RUN source .setup.sh \
    && cd repos/ts_m1m3support \
    && make SIMULATOR=1

COPY startup.sh .

SHELL ["/bin/bash", "-lc"]
ENTRYPOINT [""]
CMD ["./startup.sh"]
