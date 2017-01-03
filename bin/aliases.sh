# Set up some handy BASH aliases for the playground.
# RS21/12/2016
#
# Usage:
#
# source bin/aliases.sh
#
#
# NOTE: This relies on the docker command being usable from a non-sudo context.
# For Ubuntu, read more here: https://docs.docker.com/engine/installation/linux/ubuntulinux/#/create-a-docker-group

alias hadoop="docker exec namenode hadoop"
alias beeline="docker exec -it hive beeline"
alias spark-shell="docker exec -it spark-master spark-shell --master spark://spark-master:7077"
alias pyspark="docker exec -it spark-master pyspark"
