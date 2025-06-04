// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract AdminOnly{
    address public admin;
    uint public chest;
    address[] public users;
    uint public amt;

    mapping(address => bool) hasWithdrawn;


    constructor() {
        admin = msg.sender;
    }

    modifier adminOnly
    {
        require(admin == msg.sender);
        _;
    }

    modifier hasWithdrawnYet {
        require(!hasWithdrawn[msg.sender], "You have already withdraw amount");
        _;
    }

    function addTreasure(uint _chest) public adminOnly {
        chest = _chest;
    }

    function allowedUsers(address _user) public adminOnly{
        users.push(_user);
    }

    function checkUser () internal view returns (bool){
        for (uint i = 0; i < users.length; i++){
            if(users[i] == msg.sender){
                return true;
            }
        }
        return false;
    }

    function withdrawal( uint _amt) public hasWithdrawnYet {
        require(checkUser(), "You are not allowed to withdraw");

        amt = _amt;
        chest = (chest - _amt);
        hasWithdrawn[msg.sender] = true;
    }

    function reset() public adminOnly{
        chest = 0;
    }

    function transferAdmin (address _user) public adminOnly{
        admin = _user;
    }


}