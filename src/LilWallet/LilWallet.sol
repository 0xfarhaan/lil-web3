// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract LilWallet {
    using SafeERC20 for IERC20;
    address owner;
    bool baseImplementation;

    error AlreadyInitilised();
    error IsBaseContract();
    error NotOwner();

    event Transfer(address indexed from, address indexed to, uint256 value);

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    constructor() {
        //
        baseImplementation = true;
    }

    function initilise(address _owner) external {
        if (baseImplementation) revert IsBaseContract();
        if (owner != address(0)) revert AlreadyInitilised();
        owner = _owner;
    }

    function transferToken(
        address token,
        address _to,
        uint256 _amount
    ) external onlyOwner {
        IERC20(token).safeTransfer(_to, _amount);
        emit Transfer(address(this), _to, _amount);
    }
}
