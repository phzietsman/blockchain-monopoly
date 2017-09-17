pragma solidity ^0.4.13;

contract Owned {
    address public owner;

    function Owned() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }
}


contract MonopolyGame {
    mapping (address => address) public games;

    function newGame (string tokenName, string tokenSymbol) {
        uint256 monopolyTotalMoneyValue = 15140;
        uint8 decimals = 0;

        address newGameAddress = new MonopolyBank(monopolyTotalMoneyValue, tokenName, decimals, tokenSymbol, msg.sender);
        games[msg.sender] = newGameAddress;
    } 
}

contract MonopolyBank is Owned {
    /* Public variables of the token */
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
   
    struct Charm {
        bool assigned;
        address addr; 
    }

    mapping (string => Charm) public charmOwners;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function MonopolyBank(
        uint256 initialSupply,
        string tokenName,
        uint8 decimalUnits,
        string tokenSymbol,
        address owner
        ) {
        balanceOf[owner] = initialSupply;              // Give the creator all initial tokens
        totalSupply = initialSupply;                        // Update total supply
        name = tokenName;                                   // Set the name for display purposes
        symbol = tokenSymbol;                               // Set the symbol for display purposes
        decimals = decimalUnits;                            // Amount of decimals for display purposes
        owner = owner;

        resetGame();
    }

    /* Internal transfer, only can be called by this contract */
    function _transfer(address _from, address _to, uint _value) internal {
        require (_to != 0x0);                               // Prevent transfer to 0x0 address. Use burn() instead
        require (balanceOf[_from] > _value);                // Check if the sender has enough
        require (balanceOf[_to] + _value > balanceOf[_to]); // Check for overflows
        balanceOf[_from] -= _value;                         // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
        Transfer(_from, _to, _value);
    }

    function _assignCharm(string charmName, address _to) internal onlyOwner {
        charmOwners[charmName] = Charm({assigned:true, addr: _to});
    }

    function _payToCharm(string charmName, uint value) internal {
        require(charmOwners[charmName].assigned);
        _transfer(msg.sender, charmOwners[charmName].addr, value);
    }

    function resetGame() onlyOwner {
        charmOwners["Battleship"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Boot"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Scottie"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Iron"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Racecar"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Hat"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Thimble"] = Charm({assigned:false, addr: 0x0});
        charmOwners["Wheelbarrow"] = Charm({assigned:false, addr: 0x0});
    }

    // Assigning addresses to the different charms
    // PZ: shit way to do this
    function setBattleship(address _to) {
        _assignCharm("Battleship", _to);
    }

    function setBoot(address _to) {
        _assignCharm("Boot", _to);
    }

    function setScottie(address _to) {
        _assignCharm("Scottie", _to);
    }

    function setIron(address _to) {
        _assignCharm("Iron", _to);
    }

    function setRacecar(address _to) {
        _assignCharm("Racecar", _to);
    }

    function setHat(address _to) {
        _assignCharm("Hat", _to);
    }

    function setThimble(address _to) {
        _assignCharm("Thimble", _to);
    }

    function setWheelbarrow(address _to) {
        _assignCharm("Wheelbarrow", _to);
    }

    // Pay to a charm
    // PZ: shit way to do this
    function payBattleship(uint value) {
        _payToCharm("Battleship", value);
    }

    function payBoot(uint value) {
        _payToCharm("Boot", value);
    }

    function payScottie(uint value) {
        _payToCharm("Scottie", value);
    }

    function payIron(uint value) {
        _payToCharm("Iron", value);
    }

    function payRacecar(uint value) {
        _payToCharm("Racecar", value);
    }

    function payHat(uint value) {
        _payToCharm("Hat", value);
    }

    function payThimble(uint value) {
        _payToCharm("Thimble", value);
    }

    function payWheelbarrow(uint value) {
        _payToCharm("Wheelbarrow", value);
    }
    
}