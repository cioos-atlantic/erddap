#!/bin/bash
export $(xargs < .env)
if [ -z $DATASETS_DIR ]; then
  DATASETS_DIR=/srv/data/erddap
fi
docker run --rm -it \
  -v "${DATASETS_DIR}:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  -v "$(pwd)/content:/usr/local/tomcat/content/erddap" \
  -v "$(pwd)/logs:/erddapData/logs" \
  ${IMAGE} \
  bash -c "cd webapps/erddap/WEB-INF/ && bash DasDds.sh"