FROM centos:7
MAINTAINER Patrick <docker@patrickhenry.co.uk>
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
    && rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
    && rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
#RUN yum -y install \
#deltarpm

RUN yum clean all
RUN yum -y update

RUN yum -y install wget 
RUN yum -y install composer 

RUN cd /tmp && wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php70

RUN composer global require "laravel/installer"
Volume /var/www/html
ENV PATH="$PATH:~/.composer/vendor/bin"

EXPOSE 80 443

CMD /usr/sbin/httpd -c "ErrorLog /dev/stdout" -DFOREGROUND

CMD ["/usr/sbin/sshd", "-D"]
