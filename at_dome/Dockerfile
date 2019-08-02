FROM lsstts/develop-env:20190705_sal3.10.0_salobj

WORKDIR /home/saluser/repos/ts_config_attcs
RUN git fetch --all && git checkout "tags/v0.1-alpha.3" -b "v0.1-alpha.3"

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
