FROM lsstts/develop-env:develop
USER saluser
WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_ATDomeTrajectory.git && cd ts_ATDomeTrajectory && git checkout v0.4.1 && cd ../ts_xml && cd .. && source /opt/lsst/software/stack/loadLSST.bash && setup sconsUtils 16.0 && source /home/saluser/repos/ts_sal/setup.env && setup ts_sal -t $USER && make_salpy_libs.py ATDomeTrajectory ATDome ATMCS && cd /home/saluser/repos/ts_ATDomeTrajectory && eups declare -r . ts_ATDomeTrajectory -t $USER && setup ts_ATDomeTrajectory -t $USER && scons
WORKDIR /home/saluser
