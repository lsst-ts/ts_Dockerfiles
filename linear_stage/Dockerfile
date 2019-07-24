FROM lsstts/develop-env:20190610_sal3.10.0_salobj3.12.0
USER saluser
WORKDIR /home/saluser/repos
RUN source /opt/lsst/software/stack/loadLSST.bash && \
	source /home/saluser/repos/ts_sal/setup.env && \
	git clone https://github.com/lsst-ts/ts_linearStage && \
       	cd ts_linearStage && \
	git checkout develop && \
	pip install zaber.serial==0.8 && \
	make_salpy_libs.py LinearStage
