FROM centos:7
MAINTAINER Patrick <docker@patrickhenry.co.uk>

RUN yum -y update

EXPOSE 80 443
