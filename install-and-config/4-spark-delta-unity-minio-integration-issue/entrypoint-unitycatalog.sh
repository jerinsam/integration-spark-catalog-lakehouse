#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Start Unity Catalog UI
cd /usr/unitycatalog/unitycatalog/ui && yarn install && yarn start > /usr/unitycatalog/unity-catalog-dev/logs/ui.log 2>&1 &

# Start Unity Catalog Server
cd /usr/unitycatalog/unitycatalog && ./bin/start-uc-server > /usr/unitycatalog/unity-catalog-dev/logs/uc-server.log 2>&1 &

# Start Pyspark with delta lake, minio and unity catalog and Jupyter Lab as Pyspark environment
pyspark --name "jupyter-unity-catalog-minio-pyspark-session" \
    --master "spark://spark-master:7077" \
    --packages "io.delta:delta-spark_2.12:3.2.1,io.unitycatalog:unitycatalog-spark_2.12:0.2.0,org.apache.hadoop:hadoop-aws:3.3.4" \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=io.unitycatalog.spark.UCSingleCatalog" \
    --conf "spark.sql.catalog.unity=io.unitycatalog.spark.UCSingleCatalog" \
    --conf "spark.sql.catalog.unity.uri=http://unity-catalog:8080" \
    --conf "spark.sql.catalog.unity.token=" \
    --conf "spark.sql.defaultCatalog=unity" \
    --conf "spark.hadoop.fs.s3a.endpoint=http://minio:9000" \
    --conf "spark.hadoop.fs.s3a.access.key=root" \
    --conf "spark.hadoop.fs.s3a.secret.key=jerinminioserver" \
    --conf "spark.hadoop.fs.s3a.path.style.access=true" \
    --conf "spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem" > /usr/unitycatalog/unity-catalog-dev/logs/pyspark.log 2>&1 &

# Keep the script running
wait
