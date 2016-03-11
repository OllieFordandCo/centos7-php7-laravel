FROM centos:7
MAINTAINER Patrick <docker@patrickhenry.co.uk> 

RUN yum -y install wget
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
RUN yum-config-manager --enable remi-php70
RUN yum -y install composer

RUN composer global require "laravel/installer"

ENV PATH="$PATH:~/.composer/vendor/bin" RUN cd /var/www/html && ls

EXPOSE 80 443 22
