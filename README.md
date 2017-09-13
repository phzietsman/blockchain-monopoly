# Blockchain Tech Session #

## Requirements ##
* Nodejs + npm
* Geth (https://geth.ethereum.org/downloads/)
* Wallet (https://github.com/ethereum/mist/releases)

* VSCode + Solidity plugin

## Monopoly Rules ##

* 8 players
	* Battleship
	* Boot
	* Scottie
	* Iron
	* Racecar
	* Hat
	* Thimble
	* Wheelbarrow

* $15140 in total
* $1500 per player


## Functions Required ##

* NewGame()
* SetPlayer(string, address)
* GetPlayerList()

* PayPlayer(string, int)
* PayBank(string, int)
* RefundBank()

* PayFine(int)
* ClaimFine()  mulitsig / voting mechanism

* GetFineBalance()
* GetBalance()
* GetBankBalance()