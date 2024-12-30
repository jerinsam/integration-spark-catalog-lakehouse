#!/bin/bash

# Install UI dependencies and start the UI
cd /usr/unitycatalog/unitycatalog/ui &&  
yarn install && yarn start & 

# Start Unity Catalog Server
cd /usr/unitycatalog/unitycatalog &&  
./bin/start-uc-server & 

# Wait for background processes
wait
