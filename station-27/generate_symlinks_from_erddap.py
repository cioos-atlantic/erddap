from pathlib import Path
import re
from erddapy import ERDDAP
import httpx
import yaml
import argparse

def main(config):
    epy = ERDDAP(
        server=config["erddap_url"],
        protocol=config["protocol"],
    )

    epy.response = "csv"
    epy.dataset_id = config["dataset"]

    epy.constraints = config["constraints"]

    epy.variables = [
        config["variable"]
    ]

    try:
        df = epy.to_pandas(distinct=True)

        file_list = df.to_dict(orient="records")
        df = None

    except httpx.HTTPError as ex:
        print(ex)

    generate_from_file_list(file_list, config)

def generate_from_file_list(file_list, config):
    for row in file_list:
        nc_file = f"{row[config['variable']]}.nc"

        group_value = None
        for file in config["file_conventions"]:
            file_ext = Path(f"./{row[config['variable']]}").suffix[1:]
            matches = re.match(file['extension'], file_ext)
            if matches:
                group_value = re.match(file['file_pattern'], nc_file).group(file['group'])
                break
        
        # Find source file
        source_path = Path(config["data_root"].replace(f"__{file['group']}__", group_value))
        full_path = Path(source_path.joinpath(nc_file))

        # print(full_path)
        
        if full_path.exists():
            sym_target_dir = Path(config["output_root"].replace(f"__{file['group']}__", group_value))

            if not sym_target_dir.exists():
                sym_target_dir.mkdir(parents=True)

            sym_target_file = sym_target_dir.joinpath(nc_file)
            sym_target_virtual = full_path.absolute().as_posix().replace(config["real_output_root"], config["erddap_data_root"])

            if not sym_target_file.is_symlink():
                sym_target_file.symlink_to(sym_target_virtual)
            else:
                print(f"Target already exists! {sym_target_file}")
        else:
            print(f"{full_path.absolute().as_posix()} NOT FOUND!")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate symlinks to existing files to build virtual ERDDAP datasets.')

    parser.add_argument('config_file', help='path to a configuration YAML file')
    parser.add_argument('--time_override', type=str, help='replace time contraint in ERDDAP call')
    
    args = parser.parse_args()
    
    with open(args.config_file, 'r') as file:
        config = yaml.safe_load(file)

    if args.time_override:
        try:
            (time_key, time_value) = re.match("(time\W+)(.*)", args.time_override.strip().lower()).groups()
            config["constraints"][time_key] = time_value
        except AttributeError:
            print(f"Invalid time override \"{args.time_override}\", this argument will be ignored")

    # print(config["constraints"])
    main(config)
