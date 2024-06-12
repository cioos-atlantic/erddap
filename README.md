# Overview

This is a repository for use with the [axiom/docker-erddap docker container](https://github.com/axiom-data-science/docker-erddap)

The files and scripts in this repository were adapted from another implementation of ERDDAP being run called [erddap-gold-standard](https://github.com/cioos-atlantic/erddap-gold-standard).

Any changes, additions, or updates should be made here. Ideally no changes should be made in the root docker-erddap folder to keep future updates to the repository as straightforward as possible

# Installation 

Clone both [docker-erddap](https://github.com/axiom-data-science/docker-erddap) and [this repository](https://github.com/cioos-atlantic/erddap) onto the machine.

The .env file is set up with the assumption that the docker-erddap folder is at /opt/applications/docker-erddap and this repository within it. However, it can be placed elsewhere if the appropriate paths are updated (in both the .env file and the docker-compose.yml)

Create an .env file by copying the .env.template file and updating ERDDAP_baseUrl and ERDDAP_baseHttpsUrl in the env to match the site path

# Use

Documentation on the [docker_erddap container can be found in its repository](https://github.com/axiom-data-science/docker-erddap)

The erddap_utils script can simplify commands and actions around ERDDAP. 

> source erddap_utils.sh

# Utilities

**Refresh Datasets**

To see the most recent changes in a dataset file, may need to update the dataset or metadata.

As ERDDAP doesn't look directly at the files, but rather the compiled datasets.xml, remember to generate it with the datasetsd util first

> erddap_refresh_metadata

> erddap_refresh_dataset

**ArchiveADataset**

Create an archive of a dataset

> erddap_archive_a_dataset

**DasDds**

Can use the erddap_dasdds command from erddap_utils to identify issues with a given dataset

> erddap_dasdds

**GenerateDatasetsd**

Generates the datasets.xml file from the files located in the datasets.d folder

> erddap_generate_datasetsd

**datasets_splitter**

Splits a datasets.xml file into separate dataset files for use with datasets.d

