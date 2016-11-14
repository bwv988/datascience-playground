#!/bin/sh
# FIXME: This needs further work and documentation.

# Get lsb functions
# FIXME: Dependency on LSB.
. /lib/lsb/init-functions

FLAVOR="Zeppelin + Jupyter Docker Data Science Sandbox"
COMPOSE_ROOT="docker-compose"
COMPOSE_FILE="sandbox-zeppelin-jupyter.yml"
COMPOSE_PATH="${COMPOSE_ROOT}/${COMPOSE_FILE}"
COMPOSE_CMD="docker-compose -f ${COMPOSE_PATH}"

case "$1" in
  start)
    log_begin_msg "Starting ${FLAVOR}..."
    exec ${COMPOSE_CMD} up
    log_end_msg $?
    ;;
  stop)
    log_begin_msg "Stopping ${FLAVOR}..."
    exec ${COMPOSE_CMD} down
    log_end_msg $?
    ;;
  *)
    log_success_msg "Usage: ./sandbox.sh {start|stop}"
    exit 1
esac
