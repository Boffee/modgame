// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {Immutable} from "../codegen/tables/Immutable.sol";

contract MutableSystem is System {
  modifier onlyMutable(bytes32 entity) {
    require(!Immutable.get(entity), "Entity is immutable");
    _;
  }
}
