pragma solidity ^0.5.8;

import "./StandardToken.sol";
import "./Configurable.sol";
import "./Ownable.sol";

/*
* @title CrowdsaleToken
* @dev Contract to perform crowd sale with token
*/
contract CrowdsaleToken is StandardToken, Configurable, Ownable {
    /*
    * @dev enum of current crowd sale state
    */
    enum Stages {
        none,
        icoStart,
        icoEnd
    }

    Stages public currentStage;

    /*
    * @dev constructor of CrowdsaleToken
    */
    constructor() public {
        currentStage = Stages.none;
        balances[owner] = balances[owner].add(tokenReserve);
        totalSupply_ = totalSupply_.add(tokenReserve);
        remainingTokens = cap;
        emit Transfer(address(this), owner, tokenReserve);
    }

    /*
    * @dev fallback function to send ether to for Crowd sale
    */
    function () external payable {
        require(currentStage == Stages.icoStart);
        require(msg.value > 0);
        require(remainingTokens > 0);

        uint256 weiAmount = msg.value; // Calculate tokens to sell
        uint256 tokens = weiAmount.mul(basePrice).div(1 ether);
        uint256 returnWei = 0;

        if (tokensSold.add(tokens) > cap) {
            uint256 newTokens = cap.sub(tokensSold);
            uint256 newWei = newTokens.div(basePrice).mul(1 ether);

            returnWei = weiAmount.sub(newWei);
            weiAmount = newWei;
            tokens = newTokens;
        }

        tokensSold = tokensSold.add(tokens); // Increment raised amount
        remainingTokens = cap.sub(tokensSold);
        if (returnWei > 0) {
            msg.sender.transfer(returnWei);
            emit Transfer(address(this), msg.sender, returnWei);
        }

        balances[msg.sender] = balances[msg.sender].add(tokens);
        emit Transfer(address(this), msg.sender, tokens);
        totalSupply_ = totalSupply_.add(tokens);
        owner.transfer(weiAmount); // Send money to owner
    }

    /*
    * @dev startIco starts the public ICO
    */
    function startIco() public onlyOwner {
        require(currentStage != Stages.icoEnd);
        currentStage = Stages.icoStart;
    }

    /*
    * @dev endIco closes down the ICO
    */
    function endIco() internal {
        currentStage = Stages.icoEnd;

        // Transfer any remaining tokens
        if (remainingTokens > 0) {
            balances[owner] = balances[owner].add(remainingTokens);
        }
        // Transfer any remaining ETH balance in the contract to the owner
        owner.transfer(address(this).balance);
    }

    /*
    * @dev finalizeIco closes down the ICO and sets needed variables
    */
    function finalizeIco() public onlyOwner {
        require(currentStage != Stages.icoEnd);
        endIco();
    }
}
