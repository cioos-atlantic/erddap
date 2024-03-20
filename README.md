# Overview

This is a repository for use with the [axiom/docker-erddap docker container](https://github.com/axiom-data-science/docker-erddap)

The files and scripts in this repository were adapted from another implementation of ERDDAP being run called [erddap-gold-standard](https://github.com/cioos-atlantic/erddap-gold-standard).

Any changes, additions, or updates should be made here. Ideally no changes should be made in the root docker-erddap folder to keep future updates to the repository as straightforward as possible

# Installation 

Clone the repository onto the machine.

The .env file is set up with the assumption that the docker-erddap folder is at /opt/applications/docker-erddap, however it can be placed elsewhere if the appropriate paths are updated (in both the .env file and the docker-compose.yml)

Create an .env file bu copying the .env.template file

Update ERDDAP_baseUrl and ERDDAP_baseHttpsUrl to match the installation

# Use

Documentation on the [docker_erddap container can be found in its repository](https://github.com/axiom-data-science/docker-erddap)

The erddap_utils script can simplify commands and actions around ERDDAP.

# Utilities

erddap_utils.sh

ArchiveADataset.sh

DasDds.sh

GenerateDatasetsXml.sh

datasets_splitter.py

