#!/bin/bash

source common.sh

# FIXME: The below should be configurable / created dynamically.
CLUSTER_NETWORK="hadoop"
CLUSTER=("namenode" "datanode1" "datanode2" "dockercompose_spark-worker_1" "spark-master")

yellowprint "*** Environment settings *** \n"

echo -e "Cluster network: $CLUSTER_NETWORK"
for node in "${CLUSTER[@]}"
do
    cmd="docker inspect --format {{.NetworkSettings.Networks.${CLUSTER_NETWORK}.IPAddress}} $node"
    ip=$($cmd)

    echo -e "$node: $ip"

    # Print URLs for web uis.
    # FIXME: Source compose file and use named ports instead of hard-coded values.
    if [[ $node == *"spark-master"* ]]
    then
        greenprint "Spark Master UI: http://$ip:8080";
    elif [[ $node == *"namenode"* ]]
    then
        greenprint "Hadoop Namenode UI: http://$ip:50070";
    fi
done
