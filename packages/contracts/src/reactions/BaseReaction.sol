// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {IWorldPhysics} from "../interfaces/IWorldPhysics.sol";
import {IHookHandler} from "../interfaces/IHookHandler.sol";
import {PositionLib} from "../libraries/PositionLib.sol";

abstract contract BaseReaction is IHookHandler, System {
  function _physics() internal view returns (IWorldPhysics) {
    return IWorldPhysics(_world());
  }

  function _getEntitiesAtPosition(int128 x, int128 y)
    internal
    view
    returns (bytes32[] memory)
  {
    return PositionLib.getEntitiesAtPosition(x, y);
  }
}
