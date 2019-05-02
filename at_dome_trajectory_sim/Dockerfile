FROM lsstts/develop-env:develop
USER saluser
WORKDIR /home/saluser/repos
RUN cd ts_ATDomeTrajectory && git checkout v0.6.0 && cd ../ts_xml && cd .. && \
	source /opt/lsst/software/stack/loadLSST.bash && setup sconsUtils -t current && \ 
	source /home/saluser/repos/ts_sal/setup.env && setup ts_sal -t $USER  && setup ts_config_attcs -t current \ 
	&& make_salpy_libs.py ATDomeTrajectory ATDome ATMCS && cd /home/saluser/repos/ts_ATDomeTrajectory \
	&& eups declare -r . ts_ATDomeTrajectory -t $USER && setup ts_ATDomeTrajectory -t $USER && scons
WORKDIR /home/saluser
