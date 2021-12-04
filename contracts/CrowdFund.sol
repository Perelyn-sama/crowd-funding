// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// Declaring contract named CrowdFunding
contract CrowdFunding {
    // Declaring state varibles 
    uint amount;
    uint goal;

    function setVaribles (uint _amount, uint _goal ) public view {
        _amount = amount;
        _goal = goal;
    }
}