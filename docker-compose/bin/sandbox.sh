#!/bin/sh
# FIXME: This needs further work and documentation.

# Get lsb functions
# FIXME: Dependency on LSB.
. /lib/lsb/init-functions

FLAVOR="Zeppelin + Jupyter Data Science Sandbox"
COMPOSE_ROOT=".."
COMPOSE_FILE="sandbox-zeppelin-jupyter.yml"
DOCKER_START_CMD="docker-compose -f ${COMPOSE_ROOT}/${COMPOSE_FILE} up"
DOCKER_STOP_CMD="docker-compose -f ${COMPOSE_ROOT}/${COMPOSE_FILE} down"

case "$1" in
  start)
    log_begin_msg "Starting ${FLAVOR}..."
    exec ${DOCKER_START_CMD}
    log_end_msg $?
    ;;
  stop)
    log_begin_msg "Stopping ${FLAVOR}..."
    exec ${DOCKER_STOP_CMD}
    log_end_msg $?
    ;;
  *)
    log_success_msg "Usage: ./sandbox.sh {start|stop}"
    exit 1
esac
