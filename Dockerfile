FROM centos:7
MAINTAINER Patrick <patrick.henry@linkshare.com>
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
    && rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
    && rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

RUN yum -y install \ 
    git
    
EXPOSE 80 443 22

CMD /usr/sbin/httpd -c "ErrorLog /dev/stdout" -DFOREGROUND
