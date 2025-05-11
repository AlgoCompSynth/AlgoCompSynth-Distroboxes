#! /usr/bin/env bash

set -e

export COMPUTE_MODE=""
while [ ${#COMPUTE_MODE} -lt "3" ]
do
  read -p "Enter the compute mode: CPU or CUDA:"
  if [ "$REPLY" == "CPU" ]
  then
    export COMPUTE_MODE=$REPLY
    break
  elif [ "$REPLY" == "CUDA" ]
  then
    export COMPUTE_MODE=$REPLY
    break
  else
    continue
  fi
done

echo "COMPUTE_MODE: $COMPUTE_MODE"

echo ""
echo "Creating file './set_compute_mode.sh'"
echo "export COMPUTE_MODE=$COMPUTE_MODE" > ./set_compute_mode.sh
echo "'source' this file in scripts that need to know COMPUTE_MODE"
