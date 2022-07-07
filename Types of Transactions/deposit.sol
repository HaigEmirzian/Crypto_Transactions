// SPDX-License-Identifier: MIT

// Purpose: To deposit cryptocurrency to a crypto broker

pragma solidity ^0.8.15;

contract deposit {
    // instantiating the customer
    address customer;

    // only the customer can transfer money for the purposes of this SC
    constructor() {
        customer = msg.sender;
    }

    // attributes that verify the broker
    struct Broker {
        string name;
        address payable walletAddress;
        uint amount;
    }

    // instantiates the broker information within an array
    Broker[] public broker;

    // adds a broker to the array of brokers
    function addBroker(string memory name, address payable walletAddress, uint amount) public {
        broker.push(Broker(name, walletAddress, amount));
        }

    // find balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // allows the user to deposit into a broker
    function withdrawFrom(address walletAddress) payable public {
        addToBrokersBalance(walletAddress);
    }

    // updates the broker's balance
    function addToBrokersBalance(address walletAddress) private {
        for (uint i = 0; i < broker.length; i++){
            if (broker[i].walletAddress == walletAddress){
                broker[i].amount += msg.value;
            }
        }
    }
}
