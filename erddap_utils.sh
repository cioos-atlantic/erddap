export ERDDAP_AX_DIR=/opt/applications/docker-erddap
export ERDDAP_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
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

erddap_chown_conf() {
    sudo chown -R $USER ${ERDDAP_DIR}/conf
}

erddap_index_html() {
    curl "$ERDDAP_URL/index.html"
}

erddap_dataset_ids() {
    curl $ERDDAP_URL/tabledap/allDatasets.tsv?datasetID
}

erddap_restart() {
    pushd $ERDDAP_DIR
    sudo docker compose restart
    popd
}

erddap_generate_datasetsd(){
    sudo bash ${ERDDAP_AX_DIR}/datasets.d.sh -d ${ERDDAP_DIR}/datasets.d -o ${ERDDAP_DIR}/content/datasets.xml -w
}

erddap_refresh_dataset() {
    dataset_id=$1
    hard_flag_file=${ERDDAP_DIR}/erddap/data/hardFlag/${dataset_id}
    echo "Creating the following hard flag file to force hard refresh of all data for dataset $dataset_id"
    echo $hard_flag_file
    sudo touch $hard_flag_file
    echo "Restart ERDDAP to complete the dataset refresh"
}

erddap_refresh_metadata() {
    dataset_id=$1
    flag_file=${ERDDAP_DIR}/erddap/data/flag/${dataset_id}
    echo "Creating the flag file to notify ERDDAP to refresh its metadata contents as soon as possible for dataset $dataset_id"
    echo $flag_file
    sudo touch $flag_file
    echo "ERDDAP metadata contents for this dataset should be updated shortly."
}

erddap_dasdds() {
    # Once a dataset's XML is present in datasets.xml, use DasDds.sh on 
    # the dataset's id to test data loading with modified file/path regexes.
    pushd $ERDDAP_DIR
    sudo bash DasDds.sh
    popd
}

erddap_archive_a_dataset() {
    # Once a dataset's XML is present in datasets.xml, use ArchiveADataset.sh
    # on the dataset's id to archive and place in erddapData/ArchiveADataset
    pushd $ERDDAP_DIR
    sudo bash ArchiveADataset.sh
    popd
}

erddap_generate_datasets_xml() {
    pushd $ERDDAP_DIR
    sudo bash GenerateDatasetsXml.sh
    popd
}