pragma solidity ^0.5.8;

/*
* @title Ownable
* @dev The Ownable contract haas an owner address, and provides basic authorization control
* functions, this simplifies the implements of "user permissions".
*/
contract Ownable {
    address payable public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /*
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender account.
    */
    constructor() public {
        owner = msg.sender;
    }

    /*
    * @dev Throws if called by aany account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /*
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to
    */
    function transferOwnership(address payable newOwner) public onlyOwner {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
