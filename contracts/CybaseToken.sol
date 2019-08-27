pragma solidity ^0.5.8;

import "./CrowdsaleToken.sol";

contract CybaseToken is CrowdsaleToken {
    string public constant name = "Cybase";
    string public constant symbol = "CYB";
    uint32 public constant decimals = 18;
}
