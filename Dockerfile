FROM jnmik/docker-centos7-httpd-utilities:latest
MAINTAINER Jean-Michael Cyr <cyrjeanmichael@gmail.com>

# Update repo for php 5.6
#RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm

RUN yum -y install wget

RUN yum -y install git

RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN rpm -Uvh remi-release-7.rpm

RUN yum-config-manager --enable remi-php70

RUN yum -y install php
RUN yum -y install php70-php-mbstring
RUN yum -y install php70-php-mcrypt
RUN yum -y install php70-php-xml
RUN wget https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit


#install
WORKDIR /var/www/html/

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN git clone https://github.com/padster2015/red-fusion.git . 

RUN chmod -R guo+w storage

RUN chmod -R gu+w storage
