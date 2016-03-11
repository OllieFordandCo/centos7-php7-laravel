FROM centos:centos7
MAINTAINER Jean-Michael Cyr <cyrjeanmichael@gmail.com # Install Utilities and Base Apps 
RUN yum -y update && yum -y install httpd wget gcc gcc-c++ make nano locate git && yum -y clean all
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
RUN yum-config-manager --enable remi-php70
RUN yum -y install composer
ENV PATH="$PATH:~/.composer/vendor/bin"
EXPOSE 80 CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
