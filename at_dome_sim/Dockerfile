FROM lsstts/develop-env:20190509 

WORKDIR /home/saluser/repos
RUN cd ts_config_attcs && git pull

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
