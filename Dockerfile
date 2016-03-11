FROM jnmik/docker-centos7-httpd-utilities:latest
MAINTAINER Jean-Michael Cyr <cyrjeanmichael@gmail.com>

# Update repo for php 5.6
#RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm

RUN yum -y install wget

RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm


RUN yum-config-manager --enable remi-php70

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
