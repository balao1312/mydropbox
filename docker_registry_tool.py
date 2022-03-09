#!/usr/bin/python3

import argparse
from subprocess import check_output, STDOUT, TimeoutExpired, run, DEVNULL
import json
import sys


class Docker_registry_tool:
    def __init__(self, host, port, get_all, repo, tag, to_delete_digest):
        self.host = host
        self.port = port
        self.destination = f'{self.host}:{self.port}'
        self.get_all = get_all
        self.repo = repo
        self.tag = tag
        self.to_delete_digest = to_delete_digest

    def get_all_repo(self):
        print(f'\n==> trying to get all repo from {self.host} ...')
        cmd = f'curl --silent http://{self.destination}/v2/_catalog'
        try:
            output = check_output(
                [cmd], timeout=5, stderr=STDOUT, shell=True).decode('utf8').strip()
            repos = json.loads(output)['repositories']
            print(repos)
        except TimeoutExpired:
            print('Error: something wrong with server.')

    def show_tags(self, repo):
        print(f'\n==> trying to get all tags on repo: {repo}...')
        cmd = f'curl --silent http://{self.destination}/v2/{repo}/tags/list'
        output = check_output(
            [cmd], timeout=5, stderr=STDOUT, shell=True).decode('utf8').strip()
        print(output)

    def get_sha(self, repo, tag):
        print(f'\n==> trying to get sha256 on {repo}:{tag}...')
        cmd = f'curl --silent -X GET --header "Accept: application/vnd.docker.distribution.manifest.v2+json" -I http://{self.destination}/v2/{self.repo}/manifests/{self.tag} | grep Docker-Content-Digest '
        try:
            output = check_output(
                [cmd], timeout=5, stderr=STDOUT, shell=True).decode('utf8').strip()
            self.sha256 = output.split(' ')[1]
            print(self.sha256)
        except Exception as e:
            print(f'Error: {e}')

    def delete_digest(self, repo, tag, sha256):
        print(f'\n==> trying to delete digest on {self.repo}:{self.tag} ...')
        cmd = f'curl --silent -X DELETE http://{self.destination}/v2/{self.repo}/manifests/{self.sha256}'
        try:
            output = check_output(
                [cmd], timeout=5, stderr=STDOUT, shell=True).decode('utf8').strip()
            print(f'==> {self.repo}:{self.tag} deleted.')
        except Exception as e:
            print(f'Error: {e}')

    def run(self):
        try:
            cp = run(f'nc -vz {self.host} {self.port}', shell=True,
                     stdout=DEVNULL, stderr=DEVNULL, timeout=5)
            if cp.returncode:
                raise TimeoutExpired('nc -vz', 5)
            print(
                f'\n==> Connect to docker registry server at {self.destination} successfully.')
        except TimeoutExpired:
            print(
                f'\n==> ERROR: Can\'t connect to docker registry server at {self.host}:{self.port}.')
            sys.exit(1)

        if self.get_all == True:
            self.get_all_repo()
        if self.repo:
            self.show_tags(self.repo)
        if self.tag:
            self.get_sha(repo=self.repo, tag=self.tag)
        if self.to_delete_digest == True:
            self.delete_digest(self.repo, self.tag, self.sha256)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--server', required=True,
                        type=str, help='docker host server ip')
    parser.add_argument('-p', '--port', default=5000,
                        type=int, help='docker registry port in use')
    parser.add_argument('-g', '--get', action="store_true",
                        help='get all repositories')
    parser.add_argument('-r', '--repo', type=str,
                        help='show all tags with specific repo')
    parser.add_argument('-t', '--tag', type=str,
                        help='get sha256 from specifig repo tag')
    parser.add_argument('-d', '--to_delete_digest', action="store_true",
                        help='delete digest on tag')
    args = parser.parse_args()

    runner = Docker_registry_tool(
        host=args.server, port=args.port, get_all=args.get, repo=args.repo, tag=args.tag, to_delete_digest=args.to_delete_digest)

    runner.run()
