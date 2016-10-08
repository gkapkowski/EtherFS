# EtherFS

Easy way to interact with Ethereum contracts through file system abstraction.

## Usage

Run command:

```bash
sudo docker run -it --privileged \
     -v "$(pwd)":/workspace \
     -v "$(pwd)/etherfs":/etherfs:shared \
     gkapkowski/etherfs
```

or save file `etherfs.sh` on you disk and run it in your solidity contract directory:

```bash
cd your_contracts_dir
/path/to/etherfs.sh
```