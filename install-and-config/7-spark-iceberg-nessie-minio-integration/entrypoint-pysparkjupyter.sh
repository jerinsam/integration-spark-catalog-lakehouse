#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Start Jupyter Lab explicitly
# import pyspark command in python is required and spark session needs to be created from the jupyter notebook. 
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root > /usr/nessie/nessie-dev/logs/jupyter.log 2>&1 &

# Keep the script running
wait
