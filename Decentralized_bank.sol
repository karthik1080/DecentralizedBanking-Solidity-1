pragma solidity ^0.8.0;
// SPDX-License-Identifier: UNLICENSED
contract LendingPlatform {
    // Total deposited Ethereum
    uint public totalDeposits;

    // Mapping to store user balances
    mapping(address => uint) public balances;

    // Function to deposit Ethereum
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Function to withdraw Ethereum
    function withdraw(uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient funds.");
        balances[msg.sender] -= amount;
        totalDeposits -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Function to borrow Ethereum (simulates borrowing, doesn't involve actual transfer)
    function borrow(uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient collateral.");
        // Simulate borrowing, doesn't involve actual transfer on the blockchain
        balances[msg.sender] -= amount;
        emit Borrowed(msg.sender, amount);
    }

    // Function to repay borrowed Ethereum
    function repay(uint amount) public payable {
        require(msg.value >= amount, "Insufficient repayment amount.");
        balances[msg.sender] += amount;
        emit Repayed(msg.sender, amount);
    }

    // Function to check user balance
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    // Events for logging transactions
    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event Borrowed(address indexed user, uint amount);
    event Repayed(address indexed user, uint amount);
}
