#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then
  # Start Spark Master
  start-master.sh -p 7077 > /usr/spark/iceberg/logs/spark-master.log 2>&1 & \

  # Start Jupyter Lab
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root > /usr/spark/iceberg/logs/jupyter.log 2>&1 

  # # Start Pyspark with delta lake and Jupyter Lab as Pyspark environment
  # pyspark --name "jupyter-pyspark-session" \
  #     --master "spark://spark-master:7077" \
  #     --packages io.delta:delta-spark_2.12:3.2.0 \
  #     --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
  #     --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" > /usr/spark/iceberg/logs/pyspark.log 2>&1 

elif [ "$SPARK_WORKLOAD" == "worker" ];
then
  start-worker.sh spark://spark-master:7077 > /usr/spark/iceberg/logs/spark-worker.log 2>&1  
elif [ "$SPARK_WORKLOAD" == "history" ]
then
  start-history-server.sh > /usr/spark/iceberg/logs/spark-history-server.log 2>&1
fi