// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] wavesAddresses;


    event NewWave(address indexed from, uint256 timestamp, string message);


    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart, by skelli");
    }

    function wave(string memory _message) public {
        totalWaves +=1;
        wavesAddresses.push(msg.sender);
        console.log("%s has waved! message %s", msg.sender, _message);

        /* Store the data in the array */
        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;

        require (
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw");
    }


    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }

    function getWavers() public view{
        uint256 index = wavesAddresses.length;
        console.log("First waver:",wavesAddresses[0]);
        console.log("Last waver:",wavesAddresses[index-1]);
    }
}