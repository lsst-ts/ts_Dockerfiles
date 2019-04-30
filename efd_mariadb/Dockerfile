FROM mariadb:latest

LABEL author="Andres Anania <aanania@lsst.org>"

ENV MYSQL_ROOT_PASSWORD lssttest
ENV MYSQL_DATABASE EFD
ENV MYSQL_USER efduser
ENV MYSQL_PASSWORD lssttest

EXPOSE 3306

RUN ["mysqld_safe"]
