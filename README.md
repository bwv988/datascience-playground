# A scalable, cloud-ready environment for Data Science using Docker

**NOTE**: This repo is purely for experimentation and does not intend to provide production-grade containers.

## Introduction

This repo provides a set of files to quickly bootstrap a fully dockerized environment for doing Data Science using distributed Big Data components like Apache Spark.

All containers are available to be pulled from the central Docker hub.

This repo uses outstanding work done by the folks from [Big Data Europe](https://github.com/big-data-europe/docker-hadoop-spark-workbench.git) and others.

## Quickstart

### Starting

```bash
cd datascience-docker-sandbox
bin/sandbox.sh start
```

### Stopping

```bash
cd datascience-docker-sandbox
bin/sandbox.sh stop
```

## Components

- Apache Spark + PySpark + R + other libs
- Apache Hadoop
- Apache Zeppelin
- Apache Hive
- Apache Zookeeper
- Jupyter

## Planned

- Apache Flink
- Sparkling Water
- More libs
- Support for Rancher, Docker Swarm and Kubernetes

## Docker Compose Usage Examples

This section shows commands to launch various dockerized setups using `docker-compose`.

### Apache Zeppelin Sandbox

This is for running interactive Data Science experiments using Zeppelin and Spark.

#### Starting / Stopping

```bash
docker-compose -f sandbox-zeppelin.yml up

docker-compose -f sandbox-zeppelin.yml down
```

### Link Zeppelin with Hive

In order to access Hive from Zeppelin, some properties and dependencies have to be configured in the JDBC interpreter group.

The below is currently a work-around to inject Hive-related config into Zeppelin **after** it has been started, by PUTting config details into the Zeppelin's interpreter REST API.

So, after the sandbox has fully started and Zeppelin is up and running, execute the following command:

```bash
docker exec -it zeppelin bash
/entrypoints/inject_hive_cfg.py
```

### Troubleshooting

Investigate issues by running a shell in a container, e.g.:

```bash
docker exec -it zeppelin bash
```

### Spark Sandbox

#### Starting / Stopping

```bash
docker-compose -f sandbox-spark.yml up

docker-compose -f sandbox-spark.yml down
```

#### Spark Shell

```bash
docker exec namenode hadoop fs -mkdir /spark-logs
docker exec -it spark-master spark-shell --master spark://spark-master:7077
```

#### Copying files to HDFS

This can be achieved via the host volume which the docker container mounts:

```bash
docker exec namenode hadoop fs -ls /
docker exec namenode hadoop fs -mkdir /tmp
docker exec namenode hadoop fs -ls /
echo "Hello world" > test.txt
sudo mv test.txt ~/...FIXME...exchange/
docker exec namenode hadoop fs -put /exchange/test.txt /tmp/test.txt
./hadoop.sh fs -ls /tmp
```

### Hadoop, Hive and PostgreSQL metastore

#### Beeline CLI

Here is how to access Beeline and run SQL commands through the docker container:

```bash
docker exec -it hive beeline

beeline> !connect jdbc:hive2://hive:10000 hiveuser hiveuser
0: jdbc:hive2://hive:10000> show tables;
```

#### Verify Hive Schema version in PostgreSQL metastore

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
