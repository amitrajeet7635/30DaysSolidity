// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract SimpleIOU{
    address public owner;
    mapping(address => bool) public isRegistered;
    address[] public friendsList;
    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256)) public debts;

    constructor(){
        owner = msg.sender;
        isRegistered[msg.sender] = true;
        friendsList.push(msg.sender);
    }

    modifier onlyOwner{
        require(owner == msg.sender, "Only Owner can perform the action!");
        _;
    }

    modifier registeredFriends{
        require(isRegistered[msg.sender], "You are not in the friend list!");
        _;
    }

    function addFriend(address _friend) public onlyOwner{
        require(!isRegistered[_friend], "This friend is already registered");
        require(_friend != address(0), "Invalid Address");

        isRegistered[_friend] = true;
        friendsList.push(_friend);
    }

    function depositFunds() public payable registeredFriends{
        require(msg.value > 0, "Invalid Amount");

        balances[msg.sender] += msg.value;
    }

    function recordDebt(address _debtor, uint256 amt) public registeredFriends{
        require(_debtor != address(0),"Invalid Address");
        require(amt > 0, "Amount should be more that zero");

        debts[_debtor][msg.sender] += amt;
    }

    function payDebt(address _creditor, uint256 amt) public registeredFriends{
        require(_creditor != address(0), "Invalid Address");
        require(isRegistered[_creditor], "You are not registered");
        require(amt > 0, "Add more ETH");
        require(debts[msg.sender][_creditor] >= amt, "Itni Udhari bhi nhi hai");
        require(balances[msg.sender] >= amt, "Insuuficient Balance");

        balances[msg.sender] -= amt;
        balances[_creditor] += amt;
        debts[msg.sender][_creditor] -= amt;
    }

    function transferEth(address payable _to, uint amt) public registeredFriends{
        require(_to != address(0), "Invalid Address");
        require(isRegistered[_to], "You are not registered");
        require(amt > 0, "Add more ETH");

        balances[msg.sender] -= amt;
        _to.transfer(amt);
        balances[_to] += amt;
    }

    function transferEthWithCall(address payable _to, uint amt) public registeredFriends{
        require(_to != address(0), "Invalid Address");
        require(isRegistered[_to], "You are not registered");
        require(amt > 0, "Add more ETH");

        balances[msg.sender] -= amt;
        (bool success, ) = _to.call{value: amt}("");
        balances[_to] += amt;
        require(success, "Transfer Failed");
    }

    function withdraw(uint amt) public registeredFriends{
        require(balances[msg.sender] >= 0, "Insufficient Balance");

        balances[msg.sender] -= amt;
        (bool success, ) = payable(msg.sender).call{value: amt}("");
        require(success, "Withdraw Unsuccessful");
    }

    function checkBalance() public view returns(uint256){
        return balances[msg.sender];
    }

}