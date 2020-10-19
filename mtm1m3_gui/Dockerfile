FROM lsstts/develop-env:latest

ARG M1M3GUI_BRANCH=develop

USER root
RUN source /home/saluser/.setup.sh && conda install -y -c conda-forge pyside2 asyncqt

USER saluser

WORKDIR /home/saluser/repos/ts_xml
RUN git checkout develop && git pull

WORKDIR /home/saluser/repos
RUN git clone --branch $M1M3GUI_BRANCH https://github.com/lsst-ts/ts_m1m3supportgui

WORKDIR /home/saluser
RUN source .setup.sh \
    && make_idl_files.py MTM1M3 MTMount

COPY startup.sh .

SHELL ["/bin/bash", "-lc"]
ENTRYPOINT [""]
CMD ["/home/saluser/startup.sh"]
