// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Immutable} from "../codegen/tables/Immutable.sol";
import {ModList} from "../codegen/tables/ModList.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {MutableSystem} from "../extensions/MutableSystem.sol";

contract RegisterModSystem is AuthedSystem, MutableSystem {
  function registerMod(bytes32 entityType)
    external
    onlyApproved(entityType)
    onlyMutable(entityType)
  {
    Immutable.set(entityType, true);
    ModList.push(entityType);
  }
}
