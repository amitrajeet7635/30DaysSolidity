// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract ClickCounter {

    int256 public clickCount = 0; //Variable to store the count, using int instead of uint so that the count can be in negative as well

    function clickCountUp() public{
        clickCount = clickCount + 1;  //Incrementing the count
    }

    function clickCountDown() public{
        clickCount = clickCount - 1; //Decrementing the count
    }

}

