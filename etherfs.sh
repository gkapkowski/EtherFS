#!/bin/bash
sudo docker run -it --privileged \
     -v "$(pwd)":/workspace \
     -v "$(pwd)/etherfs":/etherfs:shared \
     gkapkowski/etherfs
