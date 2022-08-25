// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;


import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint public balanceReceived;

    address payable public owner;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        owner = payable(msg.sender);
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function tip() public payable {
        //require(msg.value = _price);
        balanceReceived += msg.value;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function withdraw(address payable to, uint256 amount) public payable {
        require(msg.sender==owner);
        to.transfer(amount);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}