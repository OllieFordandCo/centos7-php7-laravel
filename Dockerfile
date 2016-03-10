FROM centos:7
MAINTAINER Patrick <docker@patrickhenry.co.uk>


RUN yum -y install wget;

RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm

RUN yum-config-manager --enable remi-php70

RUN yum -y install composer

# # UTC Timezone & Networking
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

RUN sed -i \
    -e 's~^ServerSignature On$~ServerSignature Off~g' \
    -e 's~^ServerTokens OS$~ServerTokens Prod~g' \
    -e 's~^#ExtendedStatus On$~ExtendedStatus On~g' \
    -e 's~^DirectoryIndex \(.*\)$~DirectoryIndex \1 index.php~g' \
    -e 's~^NameVirtualHost \(.*\)$~#NameVirtualHost \1~g' \
    /etc/httpd/conf/httpd.conf
# # Disable Apache directory indexes #

RUN sed -i \
    -e 's~^IndexOptions \(.*\)$~#IndexOptions \1~g' \
    -e 's~^IndexIgnore \(.*\)$~#IndexIgnore \1~g' \
    -e 's~^AddIconByEncoding \(.*\)$~#AddIconByEncoding \1~g' \
    -e 's~^AddIconByType \(.*\)$~#AddIconByType \1~g' \
    -e 's~^AddIcon \(.*\)$~#AddIcon \1~g' \
    -e 's~^DefaultIcon \(.*\)$~#DefaultIcon \1~g' \
    -e 's~^ReadmeName \(.*\)$~#ReadmeName \1~g' \
    -e 's~^HeaderName \(.*\)$~#HeaderName \1~g' \
    /etc/httpd/conf/httpd.conf
# # Disable Apache language based content negotiation #

RUN sed -i \
    -e 's~^LanguagePriority \(.*\)$~#LanguagePriority \1~g' \
    -e 's~^ForceLanguagePriority \(.*\)$~#ForceLanguagePriority \1~g' \
    -e 's~^AddLanguage \(.*\)$~#AddLanguage \1~g' \
    /etc/httpd/conf/httpd.conf
# # Disable all Apache modules and enable the minimum #

RUN sed -i \
    -e 's~^\(LoadModule .*\)$~#\1~g' \
    -e 's~^#LoadModule mime_module ~LoadModule mime_module ~g' \
    -e 's~^#LoadModule log_config_module ~LoadModule log_config_module ~g' \
    -e 's~^#LoadModule setenvif_module ~LoadModule setenvif_module ~g' \
    -e 's~^#LoadModule status_module ~LoadModule status_module ~g' \
    -e 's~^#LoadModule authz_host_module ~LoadModule authz_host_module ~g' \
    -e 's~^#LoadModule dir_module ~LoadModule dir_module ~g' \
    -e 's~^#LoadModule alias_module ~LoadModule alias_module ~g' \
    -e 's~^#LoadModule expires_module ~LoadModule expires_module ~g' \
    -e 's~^#LoadModule deflate_module ~LoadModule deflate_module ~g' \
    -e 's~^#LoadModule headers_module ~LoadModule headers_module ~g' \
    -e 's~^#LoadModule alias_module ~LoadModule alias_module ~g' \
    /etc/httpd/conf/httpd.conf

# Global PHP configuration changes
RUN sed -i \
  -e 's~^;date.timezone =$~date.timezone = Europe/Rome~g' \
  -e 's~^;user_ini.filename =$~user_ini.filename =~g' \
   /etc/php.ini

RUN composer global require "laravel/installer"
Volume /var/www/html
ENV PATH="$PATH:~/.composer/vendor/bin"

RUN cd /var/www/html && ls

RUN laravel new blog
#RUN cd blog
#RUN chmod -R gu+w storage && chmod -R guo+w storage

EXPOSE 80 443 22

CMD /usr/sbin/httpd -c "ErrorLog /dev/stdout" -DFOREGROUND
