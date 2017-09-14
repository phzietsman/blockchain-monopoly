# Blockchain Tech Session #

## Requirements ##

Don't use the .deb if your are on Ubuntu, I had some issue starting a private node with it. Probably a PEBCAC issue :)

* Nodejs + npm
* Geth (https://geth.ethereum.org/downloads/)
* Wallet (https://github.com/ethereum/mist/releases)

Nice to haves:
* VSCode + Solidity plugin

## Starting a private Ethereum blockchain ##

Start a full private ethereum node:
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

