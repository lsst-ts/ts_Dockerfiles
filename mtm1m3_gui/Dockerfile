FROM lsstts/develop-env:latest

ARG M1M3GUI_BRANCH=develop

USER root
RUN source /home/saluser/.setup.sh && conda install -y -c conda-forge pyside2

USER saluser

WORKDIR /home/saluser/repos/ts_xml
RUN git checkout develop && git pull

WORKDIR /home/saluser/repos
RUN git clone --branch $M1M3GUI_BRANCH https://github.com/lsst-ts/ts_m1m3supportgui

WORKDIR /home/saluser
RUN source .setup.sh \
    && cd repos/ts_sal \
    && cp ../ts_xml/sal_interfaces/*.xml ../ts_xml/sal_interfaces/MTM1M3/*.xml test \
    && cd test \
    && salgenerator generate python MTM1M3

COPY startup.sh .

SHELL ["/bin/bash", "-lc"]
ENTRYPOINT [""]
CMD ["./startup.sh"]
