// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.11;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract VendingMachine {
    address public owner;
    mapping (address => uint) public donutBalances;
    constructor()
    {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint){
        return donutBalances[address(this)];
    }
    function restock(uint amount) public 
    {
        require(msg.sender == owner, "only the owner can restock this machine");
        donutBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable
    {
        require(msg.value >= amount * 0.5 ether, "you must pay at least 2 ether per donut");
        require(donutBalances[address(this)] >= amount, "vending machine does not have enough donuts for u fatass");

        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }

}