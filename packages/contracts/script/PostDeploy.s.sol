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
    // move
    world.registerHookHandler("moveForward1S", address(new MoveForward1S()));
    world.registerHookHandler("moveForward2S", address(new MoveForward2S()));
    world.registerHookHandler("moveForward4S", address(new MoveForward4S()));
    world.registerHookHandler("moveRight1S", address(new MoveRight1S()));
    world.registerHookHandler("moveRight2S", address(new MoveRight2S()));
    world.registerHookHandler("moveRight4S", address(new MoveRight4S()));
    world.registerHookHandler("moveBackward1S", address(new MoveBackward1S()));
    world.registerHookHandler("moveBackward2S", address(new MoveBackward2S()));
    world.registerHookHandler("moveBackward4S", address(new MoveBackward4S()));
    world.registerHookHandler("moveLeft1S", address(new MoveLeft1S()));
    world.registerHookHandler("moveLeft2S", address(new MoveLeft2S()));
    world.registerHookHandler("moveLeft4S", address(new MoveLeft4S()));
    world.registerHookHandler("moveRandomS", address(new MoveRandomS()));

    world.registerHookHandler("moveForward1T", address(new MoveForward1T()));
    world.registerHookHandler("moveForward2T", address(new MoveForward2T()));
    world.registerHookHandler("moveForward4T", address(new MoveForward4T()));
    world.registerHookHandler("moveRight1T", address(new MoveRight1T()));
    world.registerHookHandler("moveRight2T", address(new MoveRight2T()));
    world.registerHookHandler("moveRight4T", address(new MoveRight4T()));
    world.registerHookHandler("moveBackward1T", address(new MoveBackward1T()));
    world.registerHookHandler("moveBackward2T", address(new MoveBackward2T()));
    world.registerHookHandler("moveBackward4T", address(new MoveBackward4T()));
    world.registerHookHandler("moveLeft1T", address(new MoveLeft1T()));
    world.registerHookHandler("moveLeft2T", address(new MoveLeft2T()));
    world.registerHookHandler("moveLeft4T", address(new MoveLeft4T()));
    world.registerHookHandler("moveRandomT", address(new MoveRandomT()));

    // kill
    world.registerHookHandler("killForward1S", address(new KillForward1S()));
    world.registerHookHandler("killForward2S", address(new KillForward2S()));
    world.registerHookHandler("killForward4S", address(new KillForward4S()));
    world.registerHookHandler("killRight1S", address(new KillRight1S()));
    world.registerHookHandler("killRight2S", address(new KillRight2S()));
    world.registerHookHandler("killRight4S", address(new KillRight4S()));
    world.registerHookHandler("killBackward1S", address(new KillBackward1S()));
    world.registerHookHandler("killBackward2S", address(new KillBackward2S()));
    world.registerHookHandler("killBackward4S", address(new KillBackward4S()));
    world.registerHookHandler("killLeft1S", address(new KillLeft1S()));
    world.registerHookHandler("killLeft2S", address(new KillLeft2S()));
    world.registerHookHandler("killLeft4S", address(new KillLeft4S()));
    world.registerHookHandler("killRandomS", address(new KillRandomS()));
    world.registerHookHandler("killWithin1S", address(new KillWithin1S()));

    world.registerHookHandler("killForward1T", address(new KillForward1T()));
    world.registerHookHandler("killForward2T", address(new KillForward2T()));
    world.registerHookHandler("killForward4T", address(new KillForward4T()));
    world.registerHookHandler("killRight1T", address(new KillRight1T()));
    world.registerHookHandler("killRight2T", address(new KillRight2T()));
    world.registerHookHandler("killRight4T", address(new KillRight4T()));
    world.registerHookHandler("killBackward1T", address(new KillBackward1T()));
    world.registerHookHandler("killBackward2T", address(new KillBackward2T()));
    world.registerHookHandler("killBackward4T", address(new KillBackward4T()));
    world.registerHookHandler("killLeft1T", address(new KillLeft1T()));
    world.registerHookHandler("killLeft2T", address(new KillLeft2T()));
    world.registerHookHandler("killLeft4T", address(new KillLeft4T()));
    world.registerHookHandler("killRandomT", address(new KillRandomT()));
    world.registerHookHandler("killWithin1T", address(new KillWithin1T()));

    // attack
    world.registerHookHandler("attackForward1S", address(new AttackForward1S()));
    world.registerHookHandler("attackForward2S", address(new AttackForward2S()));
    world.registerHookHandler("attackForward4S", address(new AttackForward4S()));
    world.registerHookHandler("attackRight1S", address(new AttackRight1S()));
    world.registerHookHandler("attackRight2S", address(new AttackRight2S()));
    world.registerHookHandler("attackRight4S", address(new AttackRight4S()));
    world.registerHookHandler(
      "attackBackward1S", address(new AttackBackward1S())
    );
    world.registerHookHandler(
      "attackBackward2S", address(new AttackBackward2S())
    );
    world.registerHookHandler(
      "attackBackward4S", address(new AttackBackward4S())
    );
    world.registerHookHandler("attackLeft1S", address(new AttackLeft1S()));
    world.registerHookHandler("attackLeft2S", address(new AttackLeft2S()));
    world.registerHookHandler("attackLeft4S", address(new AttackLeft4S()));
    world.registerHookHandler("attackRandomS", address(new AttackRandomS()));
    world.registerHookHandler("attackWithin1S", address(new AttackWithin1S()));

    world.registerHookHandler("attackForward1T", address(new AttackForward1T()));
    world.registerHookHandler("attackForward2T", address(new AttackForward2T()));
    world.registerHookHandler("attackForward4T", address(new AttackForward4T()));
    world.registerHookHandler("attackRight1T", address(new AttackRight1T()));
    world.registerHookHandler("attackRight2T", address(new AttackRight2T()));
    world.registerHookHandler("attackRight4T", address(new AttackRight4T()));
    world.registerHookHandler(
      "attackBackward1T", address(new AttackBackward1T())
    );
    world.registerHookHandler(
      "attackBackward2T", address(new AttackBackward2T())
    );
    world.registerHookHandler(
      "attackBackward4T", address(new AttackBackward4T())
    );
    world.registerHookHandler("attackLeft1T", address(new AttackLeft1T()));
    world.registerHookHandler("attackLeft2T", address(new AttackLeft2T()));
    world.registerHookHandler("attackLeft4T", address(new AttackLeft4T()));
    world.registerHookHandler("attackRandomT", address(new AttackRandomT()));
    world.registerHookHandler("attackWithin1T", address(new AttackWithin1T()));

    // trigger
    world.registerHookHandler(
      "triggerForward1S", address(new TriggerForward1S())
    );
    world.registerHookHandler(
      "triggerForward2S", address(new TriggerForward2S())
    );
    world.registerHookHandler(
      "triggerForward4S", address(new TriggerForward4S())
    );
    world.registerHookHandler("triggerRight1S", address(new TriggerRight1S()));
    world.registerHookHandler("triggerRight2S", address(new TriggerRight2S()));
    world.registerHookHandler("triggerRight4S", address(new TriggerRight4S()));
    world.registerHookHandler(
      "triggerBackward1S", address(new TriggerBackward1S())
    );
    world.registerHookHandler(
      "triggerBackward2S", address(new TriggerBackward2S())
    );
    world.registerHookHandler(
      "triggerBackward4S", address(new TriggerBackward4S())
    );
    world.registerHookHandler("triggerLeft1S", address(new TriggerLeft1S()));
    world.registerHookHandler("triggerLeft2S", address(new TriggerLeft2S()));
    world.registerHookHandler("triggerLeft4S", address(new TriggerLeft4S()));
    world.registerHookHandler("triggerRandomS", address(new TriggerRandomS()));
    world.registerHookHandler("triggerWithin1S", address(new TriggerWithin1S()));

    world.registerHookHandler(
      "triggerForward1T", address(new TriggerForward1T())
    );
    world.registerHookHandler(
      "triggerForward2T", address(new TriggerForward2T())
    );
    world.registerHookHandler(
      "triggerForward4T", address(new TriggerForward4T())
    );
    world.registerHookHandler("triggerRight1T", address(new TriggerRight1T()));
    world.registerHookHandler("triggerRight2T", address(new TriggerRight2T()));
    world.registerHookHandler("triggerRight4T", address(new TriggerRight4T()));
    world.registerHookHandler(
      "triggerBackward1T", address(new TriggerBackward1T())
    );
    world.registerHookHandler(
      "triggerBackward2T", address(new TriggerBackward2T())
    );
    world.registerHookHandler(
      "triggerBackward4T", address(new TriggerBackward4T())
    );
    world.registerHookHandler("triggerLeft1T", address(new TriggerLeft1T()));
    world.registerHookHandler("triggerLeft2T", address(new TriggerLeft2T()));
    world.registerHookHandler("triggerLeft4T", address(new TriggerLeft4T()));
    world.registerHookHandler("triggerRandomT", address(new TriggerRandomT()));
    world.registerHookHandler("triggerWithin1T", address(new TriggerWithin1T()));

    vm.stopBroadcast();
  }
}
