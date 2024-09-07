// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ItemStore {
    struct itemData {
        string name;
        uint8 price;
        bool sold;
    }

    itemData theItem;
    address public owner;
    address[] buyers;

    constructor(string memory _name) {
        theItem.name = _name;
        owner = msg.sender;
    }

    function putOnSale(uint8 _price) public {
        theItem.price = _price;
        theItem.sold = false;
    }

    function toWei(uint _ether) internal pure returns (uint256) {
        return (_ether * 1000000000000000000);
    }

    function buyItem() public payable {
        if((msg.value / 1 ether) >= theItem.price) {
            owner = msg.sender;
            theItem.sold = true;
            buyers.push(msg.sender);
            uint256 balance = msg.value - (theItem.price * 1 ether); #logical error found
            if(balance > 0) payable (msg.sender).transfer(balance);
        }
    }

    function getItemData() public view returns (string memory, uint8 , bool) {
        return (theItem.name, theItem.price, theItem.sold);
    }

    function getBuyers() public view returns(uint256, address[] memory) {
        return (buyers.length, buyers);
    }
}