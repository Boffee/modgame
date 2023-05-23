// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IWorld} from "../codegen/world/IWorld.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {PositionLib} from "../libraries/PositionLib.sol";

contract AttackSystem is AuthedSystem {
  function attack(bytes32 source, bytes32 target) public onlyApproved(source) {
    require(
      PositionLib.collocated(source, target), "AttackSystem: not collocated"
    );
    IWorld(_world())._attack(source, target);
  }
}
