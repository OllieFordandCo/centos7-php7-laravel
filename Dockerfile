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

RUN yum --enablerepo=remi-php70 install php70-php-pear php70-php-bcmath php70-php-pecl-jsond-devel php70-php-mysqlnd php70-php-gd php70-php-common php70-php-fpm php70-php-intl php70-php-cli php70-php php70-php-xml php70-php-opcache php70-php-pecl-apcu php70-php-pecl-jsond php70-php-pdo php70-php-gmp php70-php-process php70-php-pecl-imagick php70-php-devel php70-php-mbstring php70-php-mcrypt
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
