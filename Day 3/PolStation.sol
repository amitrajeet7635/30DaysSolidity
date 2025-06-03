// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract PollStation{
    string[] public candidateNames;

    mapping(string => uint256) public voteCount;


    //This function ensures that the candidate should be present in the array in order to cast vote.
    function candidateExist(string memory _name) internal view returns(bool){
        for (uint i = 0 ; i < candidateNames.length; i++){
            if (keccak256(bytes(candidateNames[i])) == keccak256(bytes(_name))){
                return true;
            }
        }
        return false;
    }

    // This function adds the candidate to the array
    function addCandidate( string memory _name)public {
        candidateNames.push(_name);
        voteCount[_name] = 0;
    }

    // This function allows to cast the vote for the respective candidate, and also checks that if the candidate is added in the candidate list
    function castVote(string memory _name) public{
        require(candidateExist(_name), "You can not vote, candidate do not exist" );
        voteCount[_name]++;
    }

}