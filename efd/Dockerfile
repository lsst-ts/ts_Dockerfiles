FROM mariadb:latest

COPY efd_base.tgz /home/saluser/efd_base.tgz

WORKDIR /var/lib/mysql

RUN tar xvzpPf /home/saluser/efd_base.tgz

ENV MYSQL_ROOT_PASSWORD test
ENV MYSQL_ROOT_PASSWORD test


FROM mariadb:latest

USER root

RUN yum install -y mariadb mariadb-server

COPY efd_base.tgz /home/saluser/efd_base.tgz

WORKDIR /var/lib/mysql

RUN tar xvzpPf /home/saluser/efd_base.tgz

RUN usermod -a -G mysql saluser

RUN chmod g+rw -R /var/log/mariadb/
# RUN systemctl enable mysql

WORKDIR /home/saluser

USER saluser

COPY my.cfg /home/saluser/.my.cfg

#RUN chmod 600 /home/saluser/.my.cfg

