#!/bin/bash

# Fetch hadoop
if [[ ! -d hadoop-2.4.0/ ]]; then
  if [[ ! -f hadoop-2.4.0.tar.gz ]]; then
    wget -c https://www.apache.org/dist/hadoop/common/hadoop-2.4.0/hadoop-2.4.0.tar.gz
  fi
  tar xf hadoop-2.4.0.tar.gz
  rm hadoop-2.4.0.tar.gz
fi

# Fetch docker-registry.
if [[ ! -d docker-registry/ ]]; then
  git clone git@github.com:lyda/docker-registry.git
else
  ( cd docker-registry && git pull )
fi

# Fetch docker-registry hdfs driver.
if [[ ! -d docker-registry-driver-hdfs/ ]]; then
  git clone git@github.com:lyda/docker-registry-driver-hdfs.git
else
  ( cd docker-registry-driver-hdfs && git pull )
fi
