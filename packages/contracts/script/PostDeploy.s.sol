// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IWorld} from "../src/codegen/world/IWorld.sol";
// import {HookHandlerProxySubSystem} from
//   "../src/systems/HookHandlerProxySubSystem.sol";
import "../src/codegen/Tables.sol";
import "../src/constants.sol";
import "../src/reactions/MoveReaction.sol";
import "../src/reactions/TriggerReaction.sol";

contract PostDeploy is Script {
  function run(address worldAddress) external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    IWorld world = IWorld(worldAddress);

    // HookHandlerProxySubSystem system = new HookHandlerProxySubSystem();
    // world.registerSystem("hook", "HandlerProxy", system, false);
    // world.registerFunctionSelector(
    //   "hook", "HandlerProxy", "execute", "(bytes32,bytes32,bytes32)"
    // );
    // IWorld(worldAddress).grantAccess("", "AttackSub", address(system));
    // IWorld(worldAddress).grantAccess("", "MoveSub", address(system));
    // IWorld(worldAddress).grantAccess("", "AttributesSub", address(system));

    MoveStat.set(world, DUMMY, MoveStatData({maxDistance: 4, cooldown: 5}));
    AttackStat.set(world, DUMMY, AttackStatData({maxDistance: 1, cooldown: 5}));

    // deploy and register hook handlers
    world.registerHookHandler("moveForward1", address(new MoveForward1()));
    world.registerHookHandler("moveForward2", address(new MoveForward2()));
    world.registerHookHandler("moveForward4", address(new MoveForward4()));
    world.registerHookHandler("moveRight1", address(new MoveRight1()));
    world.registerHookHandler("moveRight2", address(new MoveRight2()));
    world.registerHookHandler("moveRight4", address(new MoveRight4()));
    world.registerHookHandler("moveBackward1", address(new MoveBackward1()));
    world.registerHookHandler("moveBackward2", address(new MoveBackward2()));
    world.registerHookHandler("moveBackward4", address(new MoveBackward4()));
    world.registerHookHandler("moveLeft1", address(new MoveLeft1()));
    world.registerHookHandler("moveLeft2", address(new MoveLeft2()));
    world.registerHookHandler("moveLeft4", address(new MoveLeft4()));

    world.registerHookHandler("triggerForward1", address(new TriggerForward1()));
    world.registerHookHandler("triggerForward2", address(new TriggerForward2()));
    world.registerHookHandler("triggerForward4", address(new TriggerForward4()));
    world.registerHookHandler("triggerRight1", address(new TriggerRight1()));
    world.registerHookHandler("triggerRight2", address(new TriggerRight2()));
    world.registerHookHandler("triggerRight4", address(new TriggerRight4()));
    world.registerHookHandler(
      "triggerBackward1", address(new TriggerBackward1())
    );
    world.registerHookHandler(
      "triggerBackward2", address(new TriggerBackward2())
    );
    world.registerHookHandler(
      "triggerBackward4", address(new TriggerBackward4())
    );
    world.registerHookHandler("triggerLeft1", address(new TriggerLeft1()));
    world.registerHookHandler("triggerLeft2", address(new TriggerLeft2()));
    world.registerHookHandler("triggerLeft4", address(new TriggerLeft4()));

    vm.stopBroadcast();
  }
}
