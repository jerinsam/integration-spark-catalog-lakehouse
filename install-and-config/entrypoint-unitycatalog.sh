#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Start UI
cd /usr/unitycatalog/unitycatalog/ui && yarn install && yarn start > /usr/unitycatalog/unity-catalog-dev/uc-logs/ui.log 2>&1 &

# Start Unity Catalog Server
cd /usr/unitycatalog/unitycatalog && ./bin/start-uc-server > /usr/unitycatalog/unity-catalog-dev/uc-logs/uc-server.log 2>&1 &


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
    --conf "spark.sql.defaultCatalog=unity" > /usr/unitycatalog/unity-catalog-dev/uc-logs/pyspark.log 2>&1 &

# Keep the script running
wait
