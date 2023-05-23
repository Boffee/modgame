// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IWorld} from "../codegen/world/IWorld.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {ON_TRIGGER} from "../constants.sol";
import {PositionLib} from "../libraries/PositionLib.sol";

contract TriggerSystem is AuthedSystem {
  function trigger(bytes32 source, bytes32 target) public onlyApproved(source) {
    require(PositionLib.withinDistance(source, target, 1), "too far away");
    IWorld(_world())._trigger(source, target);
  }
}
