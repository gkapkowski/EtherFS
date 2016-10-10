#!/bin/bash
sudo docker run -it --privileged \
     -v "$(pwd)":/etherfs/source \
     -v "$(pwd)/etherfs":/etherfs/fs:shared \
     gkapkowski/etherfs
