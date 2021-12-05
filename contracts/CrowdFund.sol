// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// Declaring contract named CrowdFunding
contract CrowdFunding {

    // Declaring state varibles 
    uint amount;
    uint goal;

    // Payable address can receive Ether
    address payable public owner;

    // contract address of the contract
    address payable public contractAddr;

    // Payable constructor can receive Ether
    constructor() internal payable {
        owner = payable(msg.sender);
        contractAddr = payable(address(this));
    }


    // To set values for state variables 
    function setVaribles (uint _amount, uint _goal ) public view {
        _amount = amount;
        _goal = goal;
    }

    event Transfer(address indexed _from, address indexed _to, uint _value);

    // Define a struct that will represent a project
    struct Project {
        string projectName;
        string startingDate;
        uint finishingDate;
        uint expectedCost;
    }

    // Define a modifier to check if amount is equal or greater than goal
    modifier validate() {
        require(amount >= goal);
        _;
    }

    // Declaring an array for projects
    Project[] public projects;

    // Function to set project info
    function setProjectInfo(string calldata projectName, string calldata startingDate, uint finishingDate, uint expectedCost) external {
        amount = expectedCost;

        // creating project and adding it to projects array
        Project memory newProject = Project(projectName, startingDate, finishingDate, expectedCost);
        projects.push(newProject);
    }

    // Defining a function to return details of a project 
    function displayProject() internal view returns(Project[] memory, address){
        // Generate different address for every project
        address projectId = address(uint(keccak256(abi.encodePacked(now))));
        return (projects, projectId);
    }

    // Defining function to deposit ether into contract 
    function deposit(uint _value) payable external validate {
        require( msg.value == amount);
        // I don't think event are needed for transfers
        // emit Transfer(msg.sender, address(this), _value * 10 ** 18);

        (bool success, ) = owner.call{value: amount}("");
        // (bool success, ) = owner.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }

    // Defining function to get balance of contract address 
    function contractBalance() public view returns(uint){
        return address(this).balance;
    }

    // Defining a function to withdraw fund to owner account
    function withdraw( uint _value) public validate{
        // I don't think event are needed for transfers
        // emit Transfer(address(this), msg.sender, _value * 10 ** 18);
    }

}