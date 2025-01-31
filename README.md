## INTEGRATION OF SPARK WITH DIFFERENT LAKEHOUSES AND CATALOGS
**DATA ENGINEERING - Integration of Spark with different metastore/ catalogs and lakehouses**
- In this tutorial, Docker Images are used to create services for Spark, Unity Catalog, Hive Metastore, Nessie, Minio etc., which is further integrated together.

**Following Integration of Services are covered -**
1. Spark and Delta Lake Integration
2. Spark, Delta Lake and Minio Integration
3. Spark, Delta Lake and Unity Cataog Integration
4. Spark, Delta Lake and Unity Catalog and Minio Integration - Issue integrating Minio with Unity Catalog due to absence of AWS endpoint parameter in server.properties of Unity Catalog
5. Spark, Delta Lake, Hive Metastore and Minio Integration
6. Spark, Iceberg and Minio Integration
7. Spark, Iceberg, Nessie and Minio Integration


**How to navigate through this Repo -**
Details of the integration can be found in **"integration-document.docx"**. Each integration is explained in detail with the snippets of configurations and details of Spark Session.

Following table will show the mapping of installation/configs and notebook script with the integration of Spark and other services.

|Integrations|Install and Config|Jupyter Notebook|
| -------- | ------- |-------- |
| Spark and Delta Lake Integration|./install-and-config/1-spark-delta-integration|./spark-working-folder/spark_apps/1-delta-lake-config.ipynb|
| Spark, Delta Lake and Minio Integration|./install-and-config/2-spark-delta-minio-integration|./spark-working-folder/spark_apps/2-delta-lake-minio-config.ipynb|
| Spark, Delta Lake and Unity Cataog Integration|./install-and-config/3-spark-delta-unity-integration|./spark-working-folder/spark_apps/3-unity-calatog-config.ipynb|
| Spark, Delta Lake and Unity Catalog and Minio Integration - Issue integrating Minio with Unity Catalog |./install-and-config/4-issue-spark-delta-unity-minio-integration|./spark-working-folder/spark_apps/4-issue-unity-calatog-and-minio-config.ipynb|
| Spark, Delta Lake, Hive Metastore and Minio Integration|./install-and-config/5-spark-delta-hivemetastore-minio-integration|./spark-working-folder/spark_apps/5-delta-hive-metastore-and-minio-config.ipynb|
| Spark, Iceberg and Minio Integration|./install-and-config/6-spark-iceberg-minio-integration|./spark-working-folder/spark_apps/6-iceberg-minio-config.ipynb|
| Spark, Iceberg, Nessie and Minio Integration|./install-and-config/7-spark-iceberg-nessie-minio-integration|./spark-working-folder/spark_apps/7-nessie-minio-config.ipynb|

In each folder, following files can be found and for better understanding follow it in the same order:
1. Dockerfile : Dockerfile for different services used in the integration.
2. entrypoint.sh: Bash script which will be executed when the container is created from the above Dockerfiles.
3. docker-compose.yml: This file is used to create and run multiple containers as a single service i.e. in the same network.
4. requirement.txt: Contains the list of python packages to be installed in the container.

