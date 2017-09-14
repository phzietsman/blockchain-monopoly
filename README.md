# Blockchain Tech Session #

## Requirements ##

Don't use the .deb if your are on Ubuntu, I had some issue starting a private node with it. Probably a PEBCAC issue :)

* Nodejs + npm
* Geth + Tools (https://geth.ethereum.org/downloads/)
* Wallet (https://github.com/ethereum/mist/releases)

Nice to haves:
* VSCode + Solidity plugin

## Starting a dev Ethereum blockchain ##

Start a dev ethereum node:
```sh
$ git clone https://github.com/phzietsman/blockchain-monopoly.git
$ cd blockchain-monopoly
$ mkdir downloads
$ cd downloads
$ cp your_download_directory/geth geth 
$ cp your_download_directory/wallet wallet 
$ ./geth --rpc --nat none --dev
```
Look for the following line after the node has started:

`IPC endpoint opened: your_ipc_endpoint`

Start an interactive client and wallet, hooked up to your local running node:
```sh
$ ./geth attach ipc:your_ipc_endpoint
$ ./wallet --rpc your_ipc_endpoint
```

Using the interactive client, create an account and start your miner:
```sh
$ personal.newAccount()
$ miner.setEtherbase(personal.listAccounts[0]) 
$ miner.start()
$ eth.getBalance(personal.listAccounts[0])
```
/tmp/ethereum_dev_mode/geth.ipc
0x53f0e8b211f6b2965f2cb50263d3c272a0f4374a

0x08A973A03495967343BE6F03194Be8A61790BfF6
1234

## Starting a PRIVATE Ethereum blockchain ##

[Official Resource](https://github.com/ethereum/go-ethereum/wiki/Private-network)

Other less official resources on creating a private network
* [The Good](https://media.consensys.net/how-to-build-a-private-ethereum-blockchain-fbf3904f337)
* [The Bad](https://souptacular.gitbooks.io/ethereum-tutorials-and-tips-by-hudson/content/private-chain.html)
* [The Ugly](https://omarmetwally.wordpress.com/2017/07/25/how-to-create-a-private-ethereum-network/)

First you need a genesis block. This will be the first block in your blockchain and other blockchain with a different chain will not sync with this private one.

```json
{
  "config": {
    "chainId": 123,
    "homesteadBlock": 0,
    "eip155Block": 0,
    "eip158Block": 0
  },
  "nonce": "0x0000000000000045",
  "timestamp": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "gasLimit": "0x8900000",
  "difficulty": "0x400",
  "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": "0xdefault_account",
  "alloc": {
    "0xdefault_account" : {"balance" : "10000000000000000000"} 
  }
}
```

Create a default account, this account will be seeded with ether in the genesis block.
```sh
$./geth account new
```


To create a database that uses this genesis block, run the following command. This will import and set the canonical genesis block for your chain.
```sh
$ ./geth --datadir blockchaindata init "../genesis.json"
```

Future runs of geth on this data directory will use the genesis block you have defined.
```sh
$ ./geth --datadir blockchaindata --identity "MyNodeName" --networkid 123
```


## Blockchain Monopoly ##

### Monopoly Guidelines ###
* 8 players (Battleship, Boot, Scottie, Iron, Racecar, Hat, Thimble, Wheelbarrow)
* Total money in circulation: **$15140**
* Each player receives **$1500** before round one
* Bank owns all the property at the start, players buy property from the bank
* Bank owns all the money at the start of the game
* The bank pays each player **$200** everytime they pass **Start**
* Fines gets paid in a **Fines Pool**  and is not owned by anybody
* Claiming the money in the **Fines Pool** needs all the player's consensus
* Players pay 'Rent' to each other when landing on an owned property   

To simplify the game, the token onwner controls the bank.  This can be a player of an external party. a better solution would be to remove the bank owner with claims against the bank which gets approved by the other players.

### Functions Required ###

Game owner functions
* NewGame()
* SetPlayer(string, address)
* BankPayPlayer(string, int)
* RefundBank()

**Fines Pool** functions
* PayFine(int)
* ClaimFine()  using mulitsig / voting mechanism
* GetFineBalance()

General / open functions
* PayBank(string, int)
* GetPlayerList()
* PayPlayer(string, int)
* GetMyBalance()
* GetBankBalance()

