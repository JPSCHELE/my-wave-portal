// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] wavesAddresses;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart, by skelli");
    }

    function wave() public {
        totalWaves +=1;
        wavesAddresses.push(msg.sender);
        console.log("%s has waved!", msg.sender);
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