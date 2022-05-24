// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] wavesAddresses;

    uint256 private seed;
    event NewWave(address indexed from, uint256 timestamp, string message);


    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;
    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart, by skelli");

        seed = (block.timestamp + block.difficulty ) % 100;
    }

    function wave(string memory _message) public {
        

        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */

        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15 min"
        );

        /*
         * Update the current timestamp we have for the user
         */

        lastWavedAt[msg.sender] = block.timestamp;
        
        totalWaves +=1;
        wavesAddresses.push(msg.sender);

        console.log("%s has waved! message %s", msg.sender, _message);

        /* Store the data in the array */
        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("RANDOM GENERATED: %d", seed);

        if (seed<=50) {

            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;

            require (
                prizeAmount <= address(this).balance,
                    "Trying to withdraw more money than the contract has."
             );
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw");

        }

        else {
            console.log("%s didnt won", msg.sender);
        }

        emit NewWave(msg.sender, block.timestamp, _message);

        
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