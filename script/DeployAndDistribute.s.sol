// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../contracts/SipToken.sol";

contract DeployAndDistribute is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SipToken token = new SipToken(10_000 * 1e18);
        address user1 = 0x1111111111111111111111111111111111111111;
        address user2 = 0x2222222222222222222222222222222222222222;
        token.transfer(user1, 1000 * 1e18);
        token.transfer(user2, 2000 * 1e18);
        vm.stopBroadcast();
    }
} 