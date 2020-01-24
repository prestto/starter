#!/bin/bash

function run_docker_env {
    echo "Building a docker environment"
    docker-compose --project-directory . -f docker/docker-compose.yml build

    echo "Running dokcer image starter"
    docker-compose --project-directory . -f docker/docker-compose.yml run --service-ports starter ./run.sh docker_server
    # docker run starter "ls"
}

function docker_server {
    echo "starting..."
    http-server src/
}

function usage {
        echo "Usage: $0 <ACTION>"
        echo "Parameters :"
        echo " - ACTION values :"
        echo "   * dev                      - Launching dev environment."
        echo "From a container:"
        echo "   * docker_server            - Launching dev environment."
}

if [[ "$1" == "" ]]; then
   echo "Missing arguments."
   usage
   exit 1
fi


# if sudo then we are not running in a docker
# run before each run to ensure no pyc are used
CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
if [ ${CAN_I_RUN_SUDO} -gt 0 ]
then
    nicecho "normal" "removing pyc files"
    sudo find . -name "*.pyc" -exec rm -f {} \;
fi

case "$1" in
        dev)
                run_docker_env
                ;;
        docker_server)
                docker_server
                ;;

        *)
                echo "Unvalid environment detected (${1})"
                usage
                exit 1
                ;;
esac
