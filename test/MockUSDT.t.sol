// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contracts/MockUSDT.sol";

contract MockUSDTTest is Test {
    MockUSDT usdt;
    address owner;
    address user1;
    address user2;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1111);
        user2 = address(0x2222);
        usdt = new MockUSDT(10_000 * 1e18);
    }

    function testInitialSupply() public {
        assertEq(usdt.totalSupply(), 10_000 * 1e18);
        assertEq(usdt.balanceOf(owner), 10_000 * 1e18);
    }

    function testTransfer() public {
        usdt.transfer(user1, 1000 * 1e18);
        assertEq(usdt.balanceOf(user1), 1000 * 1e18);
        assertEq(usdt.balanceOf(owner), 9000 * 1e18);
    }

    function testApproveAndTransferFrom() public {
        usdt.approve(user1, 500 * 1e18);
        vm.prank(user1);
        usdt.transferFrom(owner, user2, 500 * 1e18);
        assertEq(usdt.balanceOf(user2), 500 * 1e18);
        assertEq(usdt.balanceOf(owner), 9500 * 1e18);
    }

    function test_Revert_When_TransferInsufficientBalance() public {
        vm.prank(user1);
        vm.expectRevert();
        usdt.transfer(user2, 1 * 1e18); // user1 没有余额，应该失败
    }
} 