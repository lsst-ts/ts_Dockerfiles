FROM lsstts/develop-env:develop 
WORKDIR /home/saluser/repos
RUN cd ts_ATDome && git checkout tickets/DM-18860 && cd .. && source /opt/lsst/software/stack/loadLSST.bash && source /home/saluser/repos/ts_sal/setup.env && setup ts_sal -t current && setup ts_salobj -t current && setup sconsUtils -t current && make_salpy_libs.py ATDome && cd ts_ATDome && eups declare -r . ts_ATDome -t $USER && setup ts_ATDome -t $USER && scons
WORKDIR /home/saluser
