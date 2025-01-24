#!/bin/bash


# Initialize Hive schema for PostgreSQL
$HIVE_HOME/bin/schematool -initSchema -dbType postgres > /usr/hive-metastore/logs/initilizePostgres.log 2>&1

# Start Hive metastore service
$HIVE_HOME/bin/hive --service metastore  > /usr/hive-metastore/logs/hive.log 2>&1 &

# Keep the script running
tail -f /dev/null
