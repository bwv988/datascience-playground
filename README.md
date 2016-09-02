# A scalable, cloud-ready environment for Data Science using Docker

**NOTE: This is work in progress.**

## Introduction

The purpose of this repo is to bootstrap a completely dockerized environment that can be used to execute Data Science workloads in a Big Data ecosystem. The environment wraps components like Apache Spark, Apache Flink, Hive, Hadoop filesystem etc.

This repo uses outstanding work done by the folks from [Big Data Europe](https://github.com/big-data-europe/docker-hadoop-spark-workbench.git) and others.

## Components

- Apache Spark
- Apache Flink
- Apache Hadoop
- Apache Zeppelin
- Apache Hive
- Apache Zookeeper

## Docker Compose Usage Examples

This section contains some sample commands to launch various dockerized setups using `docker-compose`.

### Spark Sandbox

#### Starting / Stopping

```bash
docker-compose -f sandbox-spark.yml up

docker-compose -f sandbox-spark.yml stop && docker-compose -f sandbox-spark.yml rm
fs -mkdir /spark-logs
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

#### Starting / Stopping

```bash
docker-compose -f hadoop-hive.yml up
docker-compose -f hadoop-hive.yml stop && docker-compose -f hadoop-hive.yml rm
```

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

## Rancher

## Docker Swarm

## Kubernetes

## References

- Big Data Europe main GitHub repo: <https://github.com/big-data-europe?page=1>
- Work done by <https://github.com/earthquakesan>
