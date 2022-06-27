// SPDX-License-Identifier: MIT

// Purpose: To withdraw cryptocurrency from a crypto broker

pragma solidity ^0.8.15;

contract withdrawal {
    // instantiating the broker
    address broker;

    // only the broker can transfer money for the purposes of this SC
    constructor() {
        broker = msg.sender;
    }

    // attributes that verify the customer
    struct Customer {
        string firstName;
        string lastName;
        address payable walletAddress;
        uint amount;
    }

    // instantiates the user information within an array
    Customer[] public customer;

    // security: Ensures the sender for the withdrawal is the broker
    modifier onlyBroker() {
        require(msg.sender == broker, "For a withdrawal, the broker needs to give money");
        _;
    }

    // adds a customer to the array of customers
    function addCustomer(string memory firstName, string memory lastName, address payable walletAddress, uint amount) public onlyBroker {
        customer.push(Customer(firstName, lastName, walletAddress, amount));
        }

    function getIndex(address walletAddress) view private returns(uint) {
        for(uint i = 0; i < customer.length; i++) {
            if (customer[i].walletAddress == walletAddress) {
                return i;
            }
        }
        return 999;
    }

    function withdraw(address payable walletAddress) payable public {
        uint i = getIndex(walletAddress);
        require(msg.sender == customer[i].walletAddress, "You must be the customer to withdraw");
        customer[i].walletAddress.transfer(customer[i].amount);
    }
}
