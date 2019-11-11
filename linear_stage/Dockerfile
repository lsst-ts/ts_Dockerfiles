FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0
USER saluser
WORKDIR /home/saluser/repos
RUN source /opt/lsst/software/stack/loadLSST.bash && \
	source /home/saluser/repos/ts_sal/setup.env && \
	setup ts_idl -t current && \
	git clone https://github.com/lsst-ts/ts_linearStage && \
       	cd ts_linearStage && \
	git checkout v1.0.0 && \
	pip install zaber.serial==0.8 && \
	make_idl_files.py LinearStage
