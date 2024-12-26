#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then
  # Start Spark Master
  start-master.sh -p 7077 &
  
  # Start Jupyter Lab
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root &
  
  # Keep the script running
  wait
    
elif [ "$SPARK_WORKLOAD" == "worker" ];
then
  start-worker.sh spark://spark-master:7077
elif [ "$SPARK_WORKLOAD" == "history" ]
then
  start-history-server.sh
fi