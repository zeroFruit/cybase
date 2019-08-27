pragma solidity ^0.5.8;

/*
* @title ERC20Basic interface
* @dev Basic ERC20 interface
*/
contract ERC20Basic {
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}
