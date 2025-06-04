// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract AuctionHouse{
    address public owner;
    string public items;
    address public highestBidder;
    uint public highestBid;
    uint public auctionTime;

    constructor (string memory _items, uint _durationInSeconds){
        owner = msg.sender;
        auctionTime = block.timestamp + _durationInSeconds;
        items = _items;
        highestBid = 0;
        highestBidder = address(0);
    }

    function setBid(uint bidAmount) public {
        if(block.timestamp >= auctionTime){
           revert("Auction has been ended!");
        }

        if (bidAmount <= highestBid){
            revert("You need to bid more than the highest bid!");
        }

        highestBid = bidAmount;
        highestBidder = msg.sender;
    }

    function getBidder() public view returns (address, uint){
        if (block.timestamp >= auctionTime){
            return (highestBidder, highestBid);
        }
        else{
            revert ("Auction is still going on");  
        }
    }
    

}