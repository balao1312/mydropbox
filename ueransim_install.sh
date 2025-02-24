#!/bin/bash

cd ~
git clone https://github.com/aligungr/UERANSIM
sudo apt update
sudo apt upgrade
sudo apt install make
sudo apt install gcc
sudo apt install g++
sudo apt install libsctp-dev lksctp-tools
sudo apt install iproute2
sudo snap install cmake --classic

cd UERANSIM

# change to specific version
git checkout v3.2.6

make
