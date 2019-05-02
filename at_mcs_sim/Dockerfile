FROM lsstts/develop-env:develop
WORKDIR /home/saluser/repos
RUN git clone -b v0.4.0 https://github.com/lsst-ts/ts_ATMCSSimulator.git && cd ts_xml && cd .. && source /opt/lsst/software/stack/loadLSST.bash && setup sconsUtils -t current && source /home/saluser/repos/ts_sal/setup.env && setup ts_sal -t current && cd /home/saluser/repos/ts_ATMCSSimulator && eups declare -r . ts_ATMCSSimulator -t $USER && setup ts_ATMCSSimulator -t $USER && make_salpy_libs.py ATMCS && scons
WORKDIR /home/saluser

COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
