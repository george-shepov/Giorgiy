// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentProcessor {
    address public owner;
    mapping(address => uint256) public payments;

    event PaymentReceived(address indexed from, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Accept payments
    receive() external payable {
        require(msg.value > 0, "Payment must be greater than zero");
        payments[msg.sender] += msg.value;
        emit PaymentReceived(msg.sender, msg.value);
    }

    // Check if a user has paid enough
    function hasPaid(address user, uint256 amount) external view returns (bool) {
        return payments[user] >= amount;
    }

    // Withdraw funds (only owner)
    function withdraw() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
