// test/SipToken.t.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contracts/SipToken.sol";

contract SipTokenTest is Test {
    SipToken token;
    address owner;
    address user1;
    address user2;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1111);
        user2 = address(0x2222);
        token = new SipToken(10_000 * 1e18);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 10_000 * 1e18);
        assertEq(token.balanceOf(owner), 10_000 * 1e18);
    }

    function testTransfer() public {
        token.transfer(user1, 1000 * 1e18);
        assertEq(token.balanceOf(user1), 1000 * 1e18);
        assertEq(token.balanceOf(owner), 9000 * 1e18);
    }

    function testApproveAndTransferFrom() public {
        token.approve(user1, 500 * 1e18);
        vm.prank(user1);
        token.transferFrom(owner, user2, 500 * 1e18);
        assertEq(token.balanceOf(user2), 500 * 1e18);
        assertEq(token.balanceOf(owner), 9500 * 1e18);
    }

    function test_Revert_When_TransferInsufficientBalance() public {
        vm.prank(user1);
        vm.expectRevert();
        token.transfer(user2, 1 * 1e18); // user1 没有余额，应该失败
    }
}
