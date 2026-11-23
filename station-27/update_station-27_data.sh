# Run nafc environment
CONDA_SH="/opt/miniconda3/etc/profile.d/conda.sh"
CONDA_ENV="station_27"

# Load environment
echo "Load conda environment $CONDA_ENV"
source $CONDA_SH
conda activate $CONDA_ENV

# Run conversion
echo 'Generating Station 27 symlinks from existing datasets based on ERDDAP...'

python generate_symlinks_from_erddap.py harvest_nafc_azmp.yaml 
python generate_symlinks_from_erddap.py harvest_nafc_bulk_unsorted.yaml 
python generate_symlinks_from_erddap.py harvest_nafc_multispecies.yaml 
python generate_symlinks_from_erddap.py harvest_nafc_nsrf.yaml 

echo 'Fin.'
