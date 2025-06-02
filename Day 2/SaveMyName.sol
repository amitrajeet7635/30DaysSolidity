// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract SaveMyName{
    string public myname;
    string public myBio;

    //Setter Function
    function setName(string memory _myname) public{  
        myname = _myname;
    }

    function setBio(string memory _myBio) public{
        myBio = _myBio;
    }


    // Getter Function
    function getName() public view returns (string memory){
        return myname;
    }
    
    function getBio() public view returns (string memory){
        return myBio;
    }
}