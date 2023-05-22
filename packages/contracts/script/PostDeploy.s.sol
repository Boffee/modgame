// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IWorld} from "../src/codegen/world/IWorld.sol";
import "../src/codegen/Tables.sol";
import "../src/constants.sol";

contract PostDeploy is Script {
  function run(address worldAddress) external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    IWorld world = IWorld(worldAddress);
    MoveStat.set(world, DUMMY, MoveStatData({maxDistance: 4, cooldown: 5}));
    AttackStat.set(world, DUMMY, AttackStatData({maxDistance: 1, cooldown: 5}));

    vm.stopBroadcast();
  }
}
