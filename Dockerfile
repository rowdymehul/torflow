FROM centos:centos7

# update and install npm
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y npm supervisor wget
RUN yum install -y nodejs npm


# How to run
EXPOSE  3000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# java
RUN cd /opt; wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jre-8u51-linux-x64.tar.gz" ; tar xvf jre-8*.tar.gz ; alternatives --install /usr/bin/java java /opt/jre1.8*/bin/java 1

# elasticsearch
RUN cd /usr/share/ ; wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.0.tar.gz ; tar xzf elasticsearch-1.7.0.tar.gz

# supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# bundle the app source
COPY . /src

# Install app dependencies
RUN cd /src; npm install