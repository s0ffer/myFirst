// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract MyToken is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    /**
    MATH
    */
    using Math for uint256;
    uint256 private feeBank;
    address private feeRecipient;

    constructor(address initialOwner)
        ERC20("SofferCoin", "SFR")
        Ownable(initialOwner)
        ERC20Permit("SofferCoin")
    {
        feeRecipient = msg.sender;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        uint256 fee = value.tryDiv(100);
        _balances[feeRecipient] = fee;
        _update(from, to, value.trySub(fee));
    }   
}
