from pathlib import Path
import re

file_list_source = Path("./NAFC_station27_filenames_labelled.txt")
file_list = file_list_source.read_text().splitlines()

data_root = "/srv/data/erddap/dfo/nafc/ctd/"

source_map = {
    "Bulk": Path(data_root).joinpath("bulk_unsorted"),
    "Multi-Species": Path(data_root).joinpath("multispecies"),
    "AZMP": Path(data_root).joinpath("azmp"),
    "NSRF": Path(data_root).joinpath("nsrf"),
}

file_conventions = {
    "pcnv" : ".*_(?P<year>\d+)_\d+\.pcnv\.nc",
    "p\d+" : ".*\.p(?P<year>\d+)\.nc"
}

output_root = "/srv/data/erddap/dfo/nafc/ctd/station-27"

real_output_root = "/srv/data/erddap"
erddap_data_root = "/datasets"

for line in file_list:
    raw_file, source = line.split(", ")
    nc_file = f"{raw_file}.nc"

    year = None
    for ext in file_conventions.keys():
        file_ext = Path(f"./{raw_file}").suffix[1:]
        matches = re.match(ext, file_ext)
        if matches:
            year = re.match(file_conventions[ext], nc_file).group("year")
            break
        
    full_path = Path(source_map[source].joinpath(year, nc_file))
    if full_path.exists():
        sym_target_dir = Path(output_root).joinpath(year, source)
        if not sym_target_dir.exists():
            sym_target_dir.mkdir(parents=True)

        sym_target_file = sym_target_dir.joinpath(nc_file)

        if not sym_target_file.exists():
            sym_target_file.symlink_to(full_path.absolute().as_posix().replace(real_output_root, erddap_data_root))
    else:
        print(f"{full_path.absolute().as_posix()} NOT FOUND!")
 
