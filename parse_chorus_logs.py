import csv
import argparse
from pathlib import Path


class Parse_logs:

    def __init__(self, file_path) -> None:
        self.file = Path(file_path)
        self.parsed_file = Path(file_path).parent.joinpath(
            'subscriber_parsed.csv')

    def main(self):
        with open(self.file, 'r') as csv_file:
            csv_reader = csv.DictReader(csv_file)
            for line in csv_reader:
                # print(type(line))
                # print(line['kubernetes_namespace_name'], line['time'], line['level'], line['message'])
                with open('parsed_log.txt', 'a') as new_file:
                    new_file.write(f"[{line['@timestamp']}][{line['kubernetes_namespace_name']}][{
                                   line['level']}] {line['message']}\n")
                # break


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file_path', required=True,
                        type=str, help='parse the Chorus log for human reading.')
    args = parser.parse_args()

    worker = Parse_logs(args.file_path)

    worker.main()
