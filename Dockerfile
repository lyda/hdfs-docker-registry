FROM ubuntu:14.04
MAINTAINER Kevin Lyda <kevin@ie.suberic.net>

RUN apt-get update
RUN apt-get install -y default-jdk python-pip python-dev git liblzma-dev \
                       libevent1-dev libyaml-dev
RUN pip install -e 'git+https://github.com/bwhite/hadoopy#egg=hadoopy'

ADD hadoop-2.4.0 /opt/hadoop
ADD etc-hadoop /opt/hadoop/etc/hadoop
ADD native /opt/hadoop/lib/native
ADD start-docker-registry.sh /start-docker-registry.sh

ADD docker-registry /docker-registry
ADD docker-registry-driver-hdfs /docker-registry-driver-hdfs
ADD docker-registry/config/boto.cfg /etc/boto.cfg
ADD docker-config/config.yml docker-registry/config/config.yml

RUN pip install /docker-registry/depends/docker-registry-core
RUN pip install /docker-registry-driver-hdfs
RUN pip install /docker-registry

env DOCKER_REGISTRY_CONFIG /docker-registry/config/config.yml
env SETTINGS_FLAVOR hdfs

EXPOSE 5000

CMD ["/start-docker-registry.sh"]
