// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IWorld} from "../codegen/world/IWorld.sol";
import {Immutable} from "../codegen/tables/Immutable.sol";
import {ModList} from "../codegen/tables/ModList.sol";
import {HookHandler} from "../codegen/tables/HookHandler.sol";
import {Name} from "../codegen/tables/Name.sol";
import {Description} from "../codegen/tables/Description.sol";
import {ImageUri} from "../codegen/tables/ImageUri.sol";
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
    HookHandler.set(hookType, entityType, handler);
  }

  function createAndDefineType(
    bytes32 type_,
    uint32 attackDist,
    uint32 attackCD,
    uint32 moveDist,
    uint32 moveCD,
    string memory name,
    string memory description,
    string memory imageUri
  ) external {
    // TODO: check if using type_ is safe
    IWorld(_world())._createAndDefineType(
      _msgSender(), type_, attackDist, attackCD, moveDist, moveCD
    );
    Name.set(type_, name);
    Description.set(type_, description);
    ImageUri.set(type_, imageUri);
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
