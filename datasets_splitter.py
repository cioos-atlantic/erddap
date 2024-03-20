from lxml import etree
from pathlib import Path
import argparse

DEFAULT_OUTPUT_PATH = './datasets/'

def main(prog_args:argparse.ArgumentParser):

    context = etree.iterparse(
        prog_args.source_file, 
        events=('end', ), 
        remove_blank_text=False,
        remove_comments=False,
        strip_cdata=False
    )
    
    for event, elem in context:
        if elem.tag == 'dataset':
            title = elem.attrib['datasetID']

            filename = Path(prog_args.output).joinpath(f"{title}.xml")

            if not Path(filename).parent.exists():
                Path(filename).parent.mkdir(parents=True)

            with open(filename, 'wb') as dataset_file:
                dataset_file.write(etree.tostring(elem))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "source_file",
        help="Path to datasets.xml source file to split into separate files, 1 per dataset.",
        action="store"
    )

    parser.add_argument(
        "-o",
        "--output",
        help="Output path for XML source files.",
        action="store",
        default=DEFAULT_OUTPUT_PATH
    )

    prog_args = parser.parse_args()

    main(prog_args)