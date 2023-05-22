// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Immutable} from "../codegen/tables/Immutable.sol";
import {ModList} from "../codegen/tables/ModList.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {AuthedSystem} from "./AuthedSystem.sol";

contract RegisterModSystem is AuthedSystem {
  function registerMod(bytes32 entityType) external onlyApproved(entityType) {
    Immutable.set(entityType, true);
    ModList.push(entityType);
  }
}
