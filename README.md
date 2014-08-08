# HDFS backed docker-registry

This is a docker container definition for creating a
[docker-registry](https://github.com/docker/docker-registry)
backed by an HDFS store using the
[hdfs driver](git@gitlab.insight-centre.org:research-ops/soma-apps.git).

## Building

```bash
./fetch-depends.sh
docker build -t lyda/hdfs-docker-registry .
```

## Running

The following knobs can be used to configure this container:

  * `HADOOP_NN_HOST` (required): IP address of the hadoop host.
  * `HADOOP_NN_PORT` (required): Port of the hadoop host.
  * `STORAGE_PATH` (default: /registry): Prefix on HDFS.
  * `LOCAL_STORAGE_PATH` (default: /hdfs/registry): Prefix on local fs -
    this should probably be a `VOLUME` in docker terminology because
    volumes perform better.

```bash
docker run -h di -i -t -e HADOOP_NN_HOST=IP -e HADOOP_NN_PORT=PORT lyda/hdfs-docker-registry
```

## Hacking

There are a number of things that could be done to improve this.

  * The local storage path should be a volume for performance reasons.
  * The non-hdfs specific knobs should be documented.
  * For `x86_64` machines (aka any machine you're running this on) the
    hadoop distro provides the wrong native libs.  I include ones
    I built for `x86_64` but that's awful and terrible and please
    suggest ways I can not do this.
  * The `hdfs-site.xml` probably needs tuning. And maybe there should
    be some knobs there.
  * Move some logic out of the fetch script and into the docker file.
    Use git urls for the python packages.  Something else for hadoop?

See also the todo list in the
[hdfs driver](git@gitlab.insight-centre.org:research-ops/soma-apps.git).
