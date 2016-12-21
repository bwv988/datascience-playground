#!/bin/bash
# FIXME: This needs further work and documentation.

# Get lsb functions
# FIXME: Dependency on LSB.
. /lib/lsb/init-functions


COMPOSE_ROOT="docker-compose"

function usage {
echo -e "\n\nUsage: ./sandbox <FLAVOUR> <ACTION>

FLAVOUR:  {ds (default), spark}
ACTION    {start, stop}

Example: ./sandbox start\n"

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
    FLAVOR_MSG="Zeppelin + Jupyter Docker Data Science Sandbox"
    COMPOSE_FILE="sandbox-zeppelin-jupyter.yml"
    ;;
  spark)
    FLAVOR_MSG="Spark + Hive + Hadoop"
    COMPOSE_FILE="sandbox-spark.yml"
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
    log_begin_msg "Starting ${FLAVOR_MSG}..."
    exec ${COMPOSE_CMD} up
    log_end_msg $?
    ;;
  stop)
    log_begin_msg "Stopping ${FLAVOR_MSG}..."
    exec ${COMPOSE_CMD} down
    log_end_msg $?
    ;;
  *)
    echo "Unknown action: $action, exiting."
    usage
esac
