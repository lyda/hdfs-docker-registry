#!/bin/bash

if [[ ! -f /etc/profile.d/java.sh ]]; then
  echo 'export JAVA_HOME=$(readlink -f /usr/bin/java|sed s-/bin/java\$--)' \
    > /etc/profile.d/java.sh
  cp /etc/profile.d/java.sh /root/.bashrc
  echo 'export PATH=/opt/hadoop/bin:$PATH' >> /root/.bashrc
fi
. /root/.bashrc

if [[ -z "$HADOOP_NN_HOST" || -z "$HADOOP_NN_PORT" ]]; then
  echo "Must set HADOOP_NN_HOST and HADOOP_NN_PORT."
  exit 1
fi
sed "s/HADOOP_NN_HOST/$HADOOP_NN_HOST/;s/HADOOP_NN_PORT/$HADOOP_NN_PORT/" \
  /opt/hadoop/etc/hadoop/core-site.xml.template \
  > /opt/hadoop/etc/hadoop/core-site.xml

my_ip=$(ip -4 -o addr show eth0 | awk '{print $4}' | sed 's-/.*--')
cat << EOF
Docker registry: ${my_ip}:5000/
Talking to hdfs://${HADOOP_NN_HOST}:$HADOOP_NN_PORT/
EOF

export PYTHONUNBUFFERED=1
docker-registry
