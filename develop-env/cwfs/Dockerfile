FROM lsstts/develop-env:20190610_sal3.10.0_salobj3.12.0
WORKDIR /home/saluser/repos
USER saluser
RUN source /opt/lsst/software/stack/loadLSST.bash && git clone https://github.com/bxin/cwfs && cd cwfs \
&& eups declare -r . -t current cwfs && setup lsst_distrib -t current && setup cwfs -t current