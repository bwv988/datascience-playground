#!/bin/bash
# Quick script to interact with the playground env.

# FIXME: This needs further work and documentation.

COMPOSE_ROOT="docker-compose"

function usage {
echo -e "\n\nUsage: ./playground <FLAVOUR> <ACTION>

FLAVOUR:  {ds (default), dsj, spark, dsdb}
ACTION    {start, stop}

Example: ./playground start\n"

exit
}

# FIXME: Re-factor ugly script code.
flavour=""
action=""

if [ "$#" -eq 1 ]
then
  flavour="ds"
  action=$1
elif [ "$#" -eq 2 ]
then
  flavour=$1
  action=$2
else
  usage
fi

case "$flavour" in
  ds)
    FLAVOR_MSG="Zeppelin + Big Data stack"
    COMPOSE_FILE="playground-zeppelin.yml"
    ;;
  dsdb)
    FLAVOR_MSG="Zeppelin + Big Data stack + MariaDB"
    COMPOSE_FILE="playground-zeppelin-db.yml"
    ;;
  dsj)
      FLAVOR_MSG="Zeppelin + Jupyter + Big Data stack"
      COMPOSE_FILE="playground-zeppelin-jupyter.yml"
      ;;
  spark)
    FLAVOR_MSG="Spark + Hive + Hadoop"
    COMPOSE_FILE="playground-spark.yml"
    ;;
  *)
    echo "Unknown flavour: $flavour, exiting."
    usage
    exit 1
esac

COMPOSE_PATH="${COMPOSE_ROOT}/${COMPOSE_FILE}"
COMPOSE_CMD="docker-compose -f ${COMPOSE_PATH}"

case "$action" in
  start)
    echo -e "Starting ${FLAVOR_MSG}..."
    exec ${COMPOSE_CMD} up
    echo -e $?
    ;;
  stop)
    echo -e "Stopping ${FLAVOR_MSG}..."
    exec ${COMPOSE_CMD} down
    echo -e $?
    ;;
  *)
    echo -e "Unknown action: $action, exiting."
    usage
esac
