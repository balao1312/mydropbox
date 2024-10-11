#!/usr/bin/python3

import argparse
from pathlib import Path
import re


class Parse_K_OPC:

    def __init__(self, file_path) -> None:
        self.file = Path(file_path)
        self.parsed_file = Path(file_path).parent.joinpath(
            'subscriber_parsed.csv')
        # print(self.parsed_file.absolute())

    def main(self):
        # print(self.file)
        with open(self.file) as f:
            lines = f.readlines()
        # print(lines[1:2][0].split(',')[2])
        # print(lines[1:2][0].split(',')[3])

        # 'UE01_999002000006211,999002000006211,000102030405060708090A0B0C0D0E0F,AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH, *,,*\n'
        with open(self.parsed_file, 'w') as f:
            f.write(lines[0])

        for line in lines[1:]:
            k = line.split(',')[2].strip()
            opc = line.split(',')[3].strip()
            # print(k, opc)
            parsed_k = k[0:8] + '.' + k[8:16] + '.' + k[16:24]+'.'+k[24:32]
            parsed_opc = opc[0:8] + '.' + opc[8:16] + \
                '.' + opc[16:24]+'.'+opc[24:32]
            # print(parsed_k, parsed_opc)

            # print(line.strip().split(',')[0])
            parsed_line = f"{line.strip().split(',')[0]},{line.strip().split(',')[1].strip()},{parsed_k},{parsed_opc},{line.strip().split(',')[4]},{line.strip().split(',')[5]},{line.strip().split(',')[6]}\n"

            with open(self.parsed_file, 'a') as f:
                f.write(parsed_line)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file_path', required=True,
                        type=str, help='parse K,OPC in csv file with dots for Harmony.')
    args = parser.parse_args()

    worker = Parse_K_OPC(args.file_path)

    worker.main()
