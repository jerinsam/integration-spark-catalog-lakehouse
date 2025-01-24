#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then
  # Start Spark Master
  start-master.sh -p 7077 > /usr/spark/iceberg/logs/spark-master.log 2>&1 & \

  # # Start Jupyter Lab explicitly
  # import pyspark command in python is required and spark session needs to be created from the jupyter notebook. 
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root > /usr/spark/iceberg/logs/jupyter.log 2>&1 

elif [ "$SPARK_WORKLOAD" == "worker" ];
then
  start-worker.sh spark://spark-master:7077 > /usr/spark/iceberg/logs/spark-worker.log 2>&1  
elif [ "$SPARK_WORKLOAD" == "history" ]
then
  start-history-server.sh > /usr/spark/iceberg/logs/spark-history-server.log 2>&1
fi