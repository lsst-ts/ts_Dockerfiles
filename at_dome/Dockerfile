FROM lsstts/develop-env:salobj4_b30

WORKDIR /home/saluser/repos/ts_config_attcs
RUN git fetch --all && git checkout "tags/v0.1-alpha.5" -b "v0.1-alpha.5"

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
