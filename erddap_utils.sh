export ERDDAP_DIR=/opt/applications/docker-erddap

generate_datasetsd(){
    sudo bash ${ERDDAP_DIR}/datasets.d.sh -d ${ERDDAP_DIR}/erddap/datasets.d -o ${ERDDAP_DIR}/erddap/content/datasets.xml -w
}