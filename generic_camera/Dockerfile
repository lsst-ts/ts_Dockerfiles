FROM lsstts/develop-env:20190705_sal3.10.0_salobj

COPY Vimba_v3.0_Linux.tar /home/saluser/

RUN tar xvf Vimba_v3.0_Linux.tar

WORKDIR /home/saluser/Vimba_3_0/VimbaGigETL

USER root

RUN ./Install.sh

ENV GENICAM_GENTL64_PATH=$GENICAM_GENTL64_PATH:"/home/saluser/Vimba_3_0/VimbaGigETL/CTI/x86_64bit/"

USER saluser

WORKDIR /home/saluser/