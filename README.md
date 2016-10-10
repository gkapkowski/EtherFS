# EtherFS

[![Join the chat at https://gitter.im/EtherFS/Lobby](https://badges.gitter.im/EtherFS/Lobby.svg)](https://gitter.im/EtherFS/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Easy way to interact with Ethereum contracts through file system abstraction.

## Prerequisite

EtherFS uses docker so you have to have installed docker and have `docker` command available.
You cna find more on how to install docker here https://docs.docker.com/engine/installation/

## Install

```bash
$ sudo wget https://raw.githubusercontent.com/gkapkowski/EtherFS/master/etherfs.sh -O /usr/local/sbin/etherfs
$ sudo chmod 755 /usr/local/sbin/etherfs
```
### Run

```bash
$ cd /your/contracts/dir/
$ etherfs
```

### Run directly via docker

```bash
$ sudo docker run -it --privileged \
     -v "$(pwd)":/etherfs/source \
     -v "$(pwd)/etherfs":/etherfs/fs:shared \
     gkapkowski/etherfs
```
Use your local testnet data:

```bash
$ sudo docker run -it --privileged \
     -v "$HOME/.ethereum/testnet":/root/.ethereum/testnet \
     -v "$(pwd)":/etherfs/source \
     -v "$(pwd)/etherfs":/etherfs/fs:shared \
     gkapkowski/etherfs
```

## Usage

### Inspect contracts

We have 4 contracts in `example/Basic.sol` source file. For all of those contract EtherFS will create separate directories and fill them with files allowing access to theirs detail and actions available.

All compiled contracts:

```bash
$ ls etherfs/
Add/  Empty/  greeter/  mortal/
```
All information available for one contract:

```bash
$ ls -l etherfs/Add/
total 0
-r--r--r-- 1 root root  221 paź  8 11:42 abi
-r--r--r-- 1 root root 4782 paź  8 11:42 asm
-r--r--r-- 1 root root  132 paź  8 11:42 bin
-r--r--r-- 1 root root  100 paź  8 11:42 bin-runtime
-r--r--r-- 1 root root  128 paź  8 11:42 clone-bin
-r-xr--r-- 1 root root  100 paź  8 11:42 deploy*
-r--r--r-- 1 root root   29 paź  8 11:42 devdoc
-r--r--r-- 1 root root  380 paź  8 11:42 opcodes
-r--r--r-- 1 root root   20 paź  8 11:42 srcmap
-r--r--r-- 1 root root   78 paź  8 11:42 srcmap-runtime
-r--r--r-- 1 root root   29 paź  8 11:42 userdoc
```

Inspect ABI for contract:

```bash
$ cat etherfs/Add/abi | python -m json.tool
[
    {
        "constant": false,
        "inputs": [
            {
                "name": "a",
                "type": "uint256"
            },
            {
                "name": "b",
                "type": "uint256"
            }
        ],
        "name": "x",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "type": "function"
    }
]
```

Inspect contract opcodes:

```bash
$ cat etherfs/Add/opcodes
PUSH1 0x60 PUSH1 0x40 MSTORE PUSH1 0x31 DUP1 PUSH1 0x10 PUSH1 0x0 CODECOPY PUSH1 0x0 RETURN PUSH1 0x60 PUSH1 0x40 MSTORE PUSH1 0xE0 PUSH1 0x2 EXP PUSH1 0x0 CALLDATALOAD DIV PUSH4 0x97842CCE DUP2 EQ PUSH1 0x1C JUMPI JUMPDEST PUSH1 0x2 JUMP JUMPDEST CALLVALUE PUSH1 0x2 JUMPI PUSH1 0x24 CALLDATALOAD PUSH1 0x4 CALLDATALOAD ADD PUSH1 0x60 SWAP1 DUP2 MSTORE PUSH1 0x20 SWAP1 RETURN
```

Inspect contract code in binary format:

```bash
$ cat etherfs/Add/bin
606060405260318060106000396000f3606060405260e060020a600035046397842cce8114601c575b6002565b34600257602435600435016060908152602090f3
```


### Deploy contract (TODO)

```bash
$ etherfs/ContractName/deploy
0x1234567890ContractAddress
```


### Interact with deployed contracts (TODO)

Call contract methods:

```bash
$ etherfs/Add/instances/latest/x 12 13
25
```


### .eth files (already deployed contracts) (TODO)

All files with `.eth` extension are treated as specification files for already deployed contract. They format is:
```
0x123456789CONTRACTADDRESS
[{ ... }, { ... JSON ABI ...}]
```

For Example:

```
0xF0160428a8552AC9bB7E050D90eEADE4DDD52843
[{"inputs": [{"type": "address", "name": "_user"}], "type": "function", "constant": true, "name": "userInfo", "outputs": [{"type": "uint256", "name": "centstotal"}, {"type": "uint256", "name": "weitotal"}, {"type": "uint256", "name": "share"}, {"type": "uint256", "name": "badges"}, {"type": "bool", "name": "claimed"}]}, {"inputs": [], "type": "function", "constant": false, "name": "claim", "outputs": [{"type": "bool", "name": "success"}]}, {"inputs": [{"indexed": true, "type": "uint256", "name": "_exchange"}, {"indexed": true, "type": "uint256", "name": "_rate"}, {"indexed": true, "type": "uint256", "name": "_cents"}], "type": "event", "name": "Purchase", "anonymous": false}, {"inputs": [{"indexed": true, "type": "address", "name": "_user"}, {"indexed": true, "type": "uint256", "name": "_amount"}, {"indexed": true, "type": "uint256", "name": "_badges"}], "type": "event", "name": "Claim", "anonymous": false}]
```
