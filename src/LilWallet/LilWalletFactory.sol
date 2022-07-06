// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { Clones } from 'openzeppelin-contracts/contracts/proxy/Clones.sol';
import { LilWallet } from './LilWallet.sol';

contract LilWalletFactory {
	address baseImplementation;

	mapping(address => address[]) public implementations;

	event LogNewWallet(address indexed _address, address indexed _owner);

	constructor(address _baseImplementation) {
		baseImplementation = _baseImplementation;
	}

	function deployWalletClone() external returns (address newImplementation) {
		newImplementation = Clones.clone(baseImplementation);
		implementations[msg.sender].push(newImplementation);
		LilWallet(newImplementation).initilise(msg.sender);

		emit LogNewWallet(newImplementation, msg.sender);
	}
}
