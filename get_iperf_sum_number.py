#!/usr/bin/python3

import argparse
from pathlib import Path
import re


class Get_iperf_sum:

    def __init__(self, file_path) -> None:
        self.file = Path(file_path)

    def get_sum(self):
        # print(self.file)
        with open(self.file) as f:
            lines = f.readlines()
        # print(lines)

        sums = (line for line in lines if line[0:5] == '[SUM]')
        # print(list(sums))

        # [SUM]   0.00-1.00   sec  76.3 MBytes   640 Mbits/sec  0.090 ms  1786/58153 (3.1%)
        mbps_pattern = re.compile(r'(\d*) Mbits/sec')

        counter = 0
        total = 0.0
        for each in sums:
            try:
                mbps = float(mbps_pattern.search(each).group(1))
                counter += 1
                total += mbps
                print(f'{counter}: {mbps} Mbps')
            except Exception as e:
                pass

        print(f'\nTotal count: {counter}, AVG: {total/counter:.2f} Mbps\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file_path', required=True,
                        type=str, help='iperf txt file to calculate sum.')
    args = parser.parse_args()

    worker = Get_iperf_sum(args.file_path)

    worker.get_sum()
