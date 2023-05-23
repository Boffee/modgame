// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Immutable} from "../codegen/tables/Immutable.sol";
import {ModList} from "../codegen/tables/ModList.sol";
import {HookHandler} from "../codegen/tables/HookHandler.sol";
import {HookHandlerRegistry} from "../codegen/tables/HookHandlerRegistry.sol";
import {ModList} from "../codegen/tables/ModList.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {MutableSystem} from "../extensions/MutableSystem.sol";

contract ModSystem is AuthedSystem, MutableSystem {
  function registerHookHandler(bytes32 name, address handler) external {
    // TODO: this can be spammed
    require(HookHandlerRegistry.get(name) == address(0), "already registered");
    HookHandlerRegistry.set(name, handler);
  }

  function configureHookHandler(
    bytes32 hookType,
    bytes32 entityType,
    address handler
  ) external onlyApproved(entityType) onlyMutable(entityType) {
    Immutable.set(entityType, true);
    HookHandler.set(hookType, entityType, handler);
  }

  function registerMod(bytes32 entityType)
    external
    onlyApproved(entityType)
    onlyMutable(entityType)
  {
    Immutable.set(entityType, true);
    ModList.push(entityType);
  }
}
