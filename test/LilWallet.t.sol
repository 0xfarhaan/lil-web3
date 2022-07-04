// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {LilWallet} from "src/LilWallet/LilWallet.sol";
import {LilWalletFactory} from "src/LilWallet/LilWalletFactory.sol";
import {MockERC20} from "src/Mocks/MockERC20.sol";

contract User {}

contract LilWalletTest is Test {
    User internal user;
    MockERC20 internal token;
    LilWallet internal implementation;
    LilWalletFactory internal walletFactory;

    function setUp() public {
        token = new MockERC20();
        user = new User();
        implementation = new LilWallet();
        walletFactory = new LilWalletFactory(address(implementation));
    }

    function testNewWalletProxyDeployed() public {
        vm.prank(address(user));
        address newWalletAddrs = walletFactory.deployWalletClone();
        address newImpAddrs = walletFactory.implementations(address(user),0);
        assertEq(newWalletAddrs, newImpAddrs);
    }
}
