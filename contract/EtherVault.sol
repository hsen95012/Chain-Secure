// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherVault {

    address public owner;

    // Store user balances
    mapping(address => uint256) public balances;

    // Events
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    // Set contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function 1: Deposit Ether
    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function 2: Withdraw Ether
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    // Function 3: View Contract Balance (Owner Only)
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

