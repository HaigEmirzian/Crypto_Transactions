// SPDX-License-Identifier: MIT

// Purpose: To withdraw cryptocurrency from a crypto broker

pragma solidity ^0.8.15;

contract withdrawal {
    // instantiating the broker
    address broker;

    // only the broker can transfer money for the purposes of this SC
    constructor(){
        broker = msg.sender;
    }

    // attributes that verify the customer
    struct customer {
        string name;
        address walletAddress;
        uint amount;
    }

    
}
