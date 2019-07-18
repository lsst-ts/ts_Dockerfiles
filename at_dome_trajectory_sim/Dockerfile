FROM lsstts/develop-env:20190509

USER saluser
WORKDIR /home/saluser/repos

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
