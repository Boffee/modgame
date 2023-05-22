// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Immutable} from "../codegen/tables/Immutable.sol";
import {ModList} from "../codegen/tables/ModList.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {HookHandler} from "../codegen/tables/HookHandler.sol";
import {AuthedSystem} from "./AuthedSystem.sol";

contract RegisterHookHandlerSystem is AuthedSystem {
  function registerHookHandler(
    bytes32 hookType,
    bytes32 entityType,
    address handler
  ) external onlyApproved(entityType) {
    Immutable.set(entityType, true);
    HookHandler.set(hookType, entityType, handler);
  }
}
