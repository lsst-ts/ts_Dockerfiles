FROM lsstts/develop-env:develop

USER saluser
WORKDIR /home/saluser/repos

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
