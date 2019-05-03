FROM lsstts/develop-env:develop

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_ATPneumaticsSimulator.git && cd ts_ATPneumaticsSimulator && git checkout v0.2.0 && source /opt/lsst/software/stack/loadLSST.bash && source /home/saluser/repos/ts_sal/setup.env && setup sconsUtils -t current && setup ts_sal -t current && setup ts_salobj -t current && make_salpy_libs.py ATPneumatics && eups declare -r . ts_ATPneumaticsSimulator -t $USER && setup ts_ATPneumaticsSimulator -t $USER && scons

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
