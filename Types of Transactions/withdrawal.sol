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

    // adds a customer to the array of customers
    function addCustomer(string memory firstName, string memory lastName, address payable walletAddress, uint amount) public {
        customer.push(Customer(firstName, lastName, walletAddress, amount));
        }

    // find balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // allows the user to withdraw from a broker
    function withdrawFrom(address walletAddress) payable public {
        addToCustomersBalance(walletAddress);
    }

    // updates the customer's balance
    function addToCustomersBalance(address walletAddress) private {
        for (uint i = 0; i < customer.length; i++){
            if (customer[i].walletAddress == walletAddress){
                customer[i].amount += msg.value;
            }
        }
    }
}
