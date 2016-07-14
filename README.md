# A scalable, cloud-ready environment for Data Science using Docker

**FIXME: Work in progress**

The purpose of this PoC is to bootstrap a completely dockerized environment that can be used to execute Data Science workloads in a Big Data ecosystem. The environment wraps components like Apache Spark, Apache Flink, Hive, HDFS etc.

This repo uses outstanding work done by the folks from [Big Data Europe](https://github.com/big-data-europe/docker-hadoop-spark-workbench.git) and others.

## Quickstart: Docker compose

Below is a sequence of commands to bring up the complete environment using `docker-compose`. This neat tool comes installed by default in Docker for Mac and Windows. Linux users install it from here: <https://docs.docker.com/compose/install/>.

```bash
$ cd docker-compose

$ docker-compose up -d
Creating namenode
Creating dockercompose_spark-worker_1
Creating spark-master
Creating datanode1
Creating datanode2

# Do some work.

$ docker-compose stop && docker-compose rm
Stopping datanode2 ...
Stopping spark-master ...
Stopping datanode1 ...
Stopping dockercompose_spark-worker_1 ...
Stopping namenode ...

Going to remove datanode2, spark-master, datanode1, dockercompose_spark-worker_1, namenode
Are you sure? [yN] y
Removing datanode2 ... done
Removing spark-master ... done
Removing datanode1 ... done
Removing dockercompose_spark-worker_1 ... done
Removing namenode ... done
```

## Components

- Apache Zeppelin
- Apache Hive
- Apache Zookeeper
- Apache Spark
- Apache Flink
- Hadoop HDFS

## Example: Zeppelin Workbook

## Rancher

## Docker Swarm

## Kubernetes

## TODO and known issues

- Parsing of ports when printing environment settings.

## References

- Big Data Europe main GitHub repo: <https://github.com/big-data-europe?page=1>
- Spark containers: <https://github.com/earthquakesan/docker-spark>
- Hadoop containers:
- BDE Spark workbench: <https://github.com/big-data-europe/docker-hadoop-spark-workbench>
