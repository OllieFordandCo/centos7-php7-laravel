FROM centos:7
MAINTAINER Patrick <docker@patrickhenry.co.uk> 
RUN yum clean all
RUN yum update -y
RUN yum -y install wget
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
RUN yum-config-manager --enable remi-php70
RUN yum -y install composer
# # UTC Timezone & Networking 
RUN echo "NETWORKING=yes" > /etc/sysconfig/network
RUN composer global require "laravel/installer"
Volume /var/www/html
ENV PATH="$PATH:~/.composer/vendor/bin" RUN cd /var/www/html && ls
RUN laravel new blog
 
EXPOSE 80 443 22
