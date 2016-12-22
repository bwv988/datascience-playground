# A playground for Data Science with Spark, R, Zeppelin and Docker

**NOTE**: This repo is purely for experimentation and does not intend to provide production-grade containers.

## Introduction

This present repo provides a set of files to quickly bootstrap a fully dockerized environment for doing Data Science on top of distributed Big Data components, like Apache Spark.

All docker images are available to be pulled from the central Docker hub.

## Requirements

- [Docker](https://www.docker.com/) installed & configured for your system (Windows / macOS / Linux).
- [Docker compose](https://docs.docker.com/compose/overview/) installed.
- Recent version of `bash`. This is for accessing the aliases.

## Quickstart: Full environment

### Starting

The below starts a full stack with Spark, Hadoop, Zeppelin, Jupyter, etc.

```bash
git clone https://github.com/bwv988/datascience-docker-sandbox.git

cd datascience-docker-sandbox

bin/sandbox.sh start
```

### Stopping

```bash
bin/sandbox.sh stop
```

## Components

- Apache Spark + PySpark + R + other libs
- Apache Hadoop
- Apache Zeppelin
- Apache Hive
- Apache Zookeeper
- Jupyter

### Link Zeppelin with Hive

In order to access Hive from Zeppelin, some properties and dependencies have to be configured in the JDBC interpreter group.

The below is currently a work-around to inject Hive-related config into Zeppelin **after** it has been started, by PUTting config details into the Zeppelin's interpreter REST API.

So, after the sandbox has fully started and Zeppelin is up and running, execute the following command:

```bash
docker exec -it zeppelin bash

/entrypoints/inject_hive_cfg.py
```

### General troubleshooting

Investigate issues by running a shell in a container, e.g.:

```bash
docker exec -it zeppelin bash
```

Can also use `docker logs`:

```bash
docker logs zeppelin
```

## Spark + Hadoop environment

### Starting

```bash
cd datascience-docker-sandbox

bin/sandbox.sh spark start
```

### Verify containers are up and running

```bash
docker ps
```

### Stopping

```bash
bin/sandbox.sh spark start
```

## Usage examples

For the subsequent examples I'll be making use of the aliases provided.

### Launch Spark Shell

This is handy for running some quick tests in Scala.

```bash
# First source the aliases definitions.
source bin/aliases.sh

# Create spark logs dir in HDFS or we get an exception.
hadoop fs -mkdir /spark-logs

spark-shell
```

### Launch PySpark

Same as above, only for PySpark.

```bash
hadoop fs -mkdir /spark-logs

pyspark
```

### Copying files to HDFS

This can be achieved via the host volume which the docker container mounts:

```bash
hadoop fs -ls /

hadoop fs -mkdir /tmp

hadoop fs -ls /

echo "Hello world" > test.txt

sudo mv test.txt ~/datascience-sandbox/workdir

hadoop fs -put /workdir/test.txt /tmp/test.txt

hadoop fs -ls /tmp
```

### Acessing Beeline CLI

Here is how to access Beeline and run SQL commands through the docker container:

```bash
beeline

beeline> !connect jdbc:hive2://hive:10000 hiveuser hiveuser
0: jdbc:hive2://hive:10000> show tables
```

### Verify Hive schema version in PostgreSQL metastore

```bash
docker exec -it postgres psql -U postgres

postgres=# \c metastore
You are now connected to database "metastore" as user "postgres".
metastore=# select * from "VERSION";
 VER_ID | SCHEMA_VERSION |         VERSION_COMMENT          
--------+----------------+----------------------------------
      1 | 1.2.0          | Set by MetaStore root@172.18.0.7
(1 row)

metastore=#
```

## Deploy into AWS via Rancher

TBD

## Deploy into AWS via Docker Swarm

TBD

## Deploy using Kubernetes

TBD

## References

- Big Data Europe main GitHub repo: <https://github.com/big-data-europe?page=1>
- Work done by <https://github.com/earthquakesan>
