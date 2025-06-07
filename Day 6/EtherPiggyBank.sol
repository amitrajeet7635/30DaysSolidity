// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract PiggyBank{
    address public bankManager;
    address[] public users;

    mapping(address => bool) isRegistered;
    mapping(address => uint256 ) bankBalance;


    constructor(){
        bankManager = msg.sender;
    }

    modifier onlyManager {
        require(bankManager == msg.sender);
        _;
    }

    modifier registeredUser{
        require(isRegistered[msg.sender], "You are not registered!");
        _;
    }

    function registerUser(address _user) public onlyManager{
        users.push(_user);
        isRegistered[_user] = true;
        bankBalance[_user] = 0;

    }

    // function addFunds(uint amt) public  registeredUser {
    //     require(amt > 0, "Invalid amount");
    //     bankBalance[msg.sender] += amt;
        
    // }

    function addRealEth() public payable registeredUser{
        require(msg.value > 0, "Invalid Amount");
        bankBalance[msg.sender] += msg.value;
    }

    // function withdrawFunds(uint amt) public registeredUser{
    //     require(amt > 0, "Invalid Amount");
    //     require(bankBalance[msg.sender] >= amt, "Insufficient Balance" );
    //     bankBalance[msg.sender] -= amt;
    // }

    function withdrawRealEth() public payable registeredUser{
        require(msg.value > 0, "Invalid Amount");
        require(bankBalance[msg.sender] >= msg.value, "Insufficient Balance");
        bankBalance[msg.sender] -= msg.value;
    }

    function getBalance() public view returns(uint){
        return bankBalance[msg.sender];
    } 

}


//Dummy Accounts
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db