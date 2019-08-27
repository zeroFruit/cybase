pragma solidity ^0.5.8;

contract Configurable {
    uint256 public constant cap = 1000000*10**18;
    uint256 public constant basePrice = 100*10**18; // tokens per 1 ether
    uint256 public tokensSold = 0;

    uint256 public constant tokenReserve = 1000000*10**18;
    uint256 public remainingTokens = 0;
}
