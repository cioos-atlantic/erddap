#!/bin/bash
source $(pwd)/.env
if [[ -z $DATASETS_DIR ]] || [[ -z $IMAGE ]]; then
  echo "Error: DATASETS_DIR and/or IMAGE not set in docker compose .env file. Exiting."
  exit 1
fi
docker run --rm -it \
  -v "${DATASETS_DIR}:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  -v "$(pwd)/content:/usr/local/tomcat/content/erddap" \
  -v "$(pwd)/erddapData:/erddapData" \
  ${IMAGE} \
  bash -c "cd webapps/erddap/WEB-INF/ && bash ArchiveADataset.sh -verbose"
