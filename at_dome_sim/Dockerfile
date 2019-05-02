FROM lsstts/develop-env:develop 
WORKDIR /home/saluser/repos
RUN cd ts_config_attcs && git pull && cd .. && cd ts_ATDome && git fetch && git checkout v0.5.0 && cd .. && source /opt/lsst/software/stack/loadLSST.bash && source /home/saluser/repos/ts_sal/setup.env && setup ts_sal -t current && cd ts_salobj && git fetch && git checkout v3.12.0 && cd .. && setup ts_salobj -t current && setup sconsUtils -t current && make_salpy_libs.py ATDome && cd ts_ATDome && eups declare -r . ts_ATDome -t $USER && setup ts_config_attcs -t current && setup ts_ATDome -t $USER && scons
WORKDIR /home/saluser
