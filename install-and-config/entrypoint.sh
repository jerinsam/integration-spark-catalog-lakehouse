#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then
  # Start Spark Master
  start-master.sh -p 7077

elif [ "$SPARK_WORKLOAD" == "jupyter-pyspark" ];
then
   
  # Start Jupyter Lab
  # jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root &

  # Start Pyspark with delta lake and Jupyter Lab as Pyspark environment
  # pyspark --packages io.delta:delta-spark_2.12:3.2.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" &
  
  # Start Pyspark with delta lake and unity catalog and Jupyter Lab as Pyspark environment
  pyspark --name "unity-catalog-pyspark-session" \
    --master "spark://spark-master:7077" \
    --packages "io.delta:delta-spark_2.12:3.2.1,io.unitycatalog:unitycatalog-spark_2.12:0.2.0" \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=io.unitycatalog.spark.UCSingleCatalog" \
    --conf "spark.sql.catalog.unity=io.unitycatalog.spark.UCSingleCatalog" \
    --conf "spark.sql.catalog.unity.uri=http://unity-catalog:8080" \
    --conf "spark.sql.catalog.unity.token=" \
    --conf "spark.sql.defaultCatalog=unity" &

  # Keep the script running
  wait
    
elif [ "$SPARK_WORKLOAD" == "worker" ];
then
  start-worker.sh spark://spark-master:7077
elif [ "$SPARK_WORKLOAD" == "history" ]
then
  start-history-server.sh
fi