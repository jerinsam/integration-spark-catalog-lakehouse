#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Start UI
cd /usr/unitycatalog/unitycatalog/ui && yarn install && yarn start > ui.log 2>&1 &

# Start Unity Catalog Server
cd /usr/unitycatalog/unitycatalog && ./bin/start-uc-server > uc-server.log 2>&1 &

# Start PySpark with Jupyter
pyspark --name "unity-catalog-pyspark-session" \
    --master "spark://spark-master:7077" \
    --packages "io.delta:delta-spark_2.12:3.2.1,io.unitycatalog:unitycatalog-spark_2.12:0.2.0" \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=io.unitycatalog.spark.UCSingleCatalog" \
    --conf "spark.sql.catalog.unity=io.unitycatalog.spark.UCSingleCatalog" \
    --conf "spark.sql.catalog.unity.uri=http://unity-catalog:8080" \
    --conf "spark.sql.catalog.unity.token=" \
    --conf "spark.sql.defaultCatalog=unity" > pyspark.log 2>&1 &

# Wait for background processes
wait
