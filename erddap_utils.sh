export ERDDAP_AX_DIR=/opt/applications/docker-erddap
export ERDDAP_DIR=/opt/applications/docker-erddap/erddap
export ERDDAP_DATASETS_XML=${ERDDAP_DIR}/content/datasets.xml
export ERDDAP_DATASETSD_DIR=${ERDDAP_DIR}/datasets.d
export ERDDAP_DATA_DIR=/srv/data/erddap
if [ -z $ERDDAP_URL ]; then
    export ERDDAP_URL=http://127.0.0.1:8080/erddap
fi

erddap_vars() {
    echo "ERDDAP_DIR: $ERDDAP_DIR"
    echo "ERDDAP_AX_DIR: $ERDDAP_AX_DIR"
    echo "ERDDAP_DATASETS_XML: $ERDDAP_DATASETS_XML"
    echo "ERDDAP_DATASETSD_DIR: $ERDDAP_DATASETSD_DIR"
    echo "ERDDAP_URL: $ERDDAP_URL"
}

erddap_ax_cd() {
    cd $ERDDAP_AX_DIR
}

erddap_cd() {
    cd $ERDDAP_DIR
}

erddap_chown_datasets() {
    sudo chown $USER ${ERDDAP_DATASETS_XML}
}

erddap_chown_content() {
    sudo chown -R $USER ${ERDDAP_DIR}/content
}

erddap_index_html() {
    curl "$ERDDAP_URL/index.html"
}

erddap_dataset_ids() {
    curl $ERDDAP_URL/tabledap/allDatasets.tsv?datasetID
}

erddap_restart() {
    pushd $ERDDAP_DIR
    sudo docker compose restart docker_erddap
    popd
}

erddap_generate_datasetsd(){
    sudo bash ${ERDDAP_AX_DIR}/datasets.d.sh -d ${ERDDAP_DIR}/datasets.d -o ${ERDDAP_DIR}/content/datasets.xml -w
}