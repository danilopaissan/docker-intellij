#!/bin/bash

# Launches IntelliJ IDEA inside a Docker container

DOCKER_GROUP_ID=$(dscl . -read /Groups/staff | awk '($1 == "PrimaryGroupID:") { print $2 }')
USER_ID=$(id -u $(whoami))
GROUP_ID=$(id -g $(whoami))
HOME_DIR=$(dscl . -read /Users/$(whoami) | awk '($1 == "NFSHomeDirectory:") { print $2 }')

# Need to give the container access to your windowing system
# export DISPLAY=:10
xhost + 127.0.0.1

CMD="docker run --detach=true \
                --group-add ${DOCKER_GROUP_ID} \
                --env HOME=${HOME} \
                --env DISPLAY=unix${DISPLAY} \
                --interactive \
                --net "host" \
                --rm \
                --tty \
                --user=${USER_ID}:${GROUP_ID} \
                --volume $HOME:${HOME} \
                -e DISPLAY=host.docker.internal:0
                --volume /var/run/docker.sock:/var/run/docker.sock \
                --workdir ${HOME} \
                inellij-local"

# $CMD

echo $CMD
CONTAINER=$($CMD)

CMD="docker attach $CONTAINER"
echo $CMD
$CMD
