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
import "../src/reactions/KillReaction.sol";
import "../src/reactions/AttackReaction.sol";

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

    world.registerHookHandler("killForward1", address(new KillForward1()));
    world.registerHookHandler("killForward2", address(new KillForward2()));
    world.registerHookHandler("killForward4", address(new KillForward4()));
    world.registerHookHandler("killRight1", address(new KillRight1()));
    world.registerHookHandler("killRight2", address(new KillRight2()));
    world.registerHookHandler("killRight4", address(new KillRight4()));
    world.registerHookHandler("killBackward1", address(new KillBackward1()));
    world.registerHookHandler("killBackward2", address(new KillBackward2()));
    world.registerHookHandler("killBackward4", address(new KillBackward4()));
    world.registerHookHandler("killLeft1", address(new KillLeft1()));
    world.registerHookHandler("killLeft2", address(new KillLeft2()));
    world.registerHookHandler("killLeft4", address(new KillLeft4()));

    world.registerHookHandler("attackForward1", address(new AttackForward1()));
    world.registerHookHandler("attackForward2", address(new AttackForward2()));
    world.registerHookHandler("attackForward4", address(new AttackForward4()));
    world.registerHookHandler("attackRight1", address(new AttackRight1()));
    world.registerHookHandler("attackRight2", address(new AttackRight2()));
    world.registerHookHandler("attackRight4", address(new AttackRight4()));
    world.registerHookHandler("attackBackward1", address(new AttackBackward1()));
    world.registerHookHandler("attackBackward2", address(new AttackBackward2()));
    world.registerHookHandler("attackBackward4", address(new AttackBackward4()));
    world.registerHookHandler("attackLeft1", address(new AttackLeft1()));
    world.registerHookHandler("attackLeft2", address(new AttackLeft2()));
    world.registerHookHandler("attackLeft4", address(new AttackLeft4()));

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
