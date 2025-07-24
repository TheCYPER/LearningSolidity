// script/DeployAndDistribute.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../contracts/SipToken.sol";

contract DeployAndDistribute is Script {
    function run() external {
        // 1. 获取部署者私钥
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // 2. 开始广播（用部署者身份发交易）
        vm.startBroadcast(deployerPrivateKey);

        // 3. 部署合约，初始发行 10000 SIP
        SipToken token = new SipToken(10_000 * 1e18);

        // 4. 假设我们要分发给两个用户
        address user1 = 0x1111111111111111111111111111111111111111;
        address user2 = 0x2222222222222222222222222222222222222222;

        // 5. 分发代币
        token.transfer(user1, 1000 * 1e18);
        token.transfer(user2, 2000 * 1e18);  

        vm.stopBroadcast();
    }
} 