// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {Orientation} from "../codegen/tables/Orientation.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";
import {IWorldPhysics} from "../interfaces/IWorldPhysics.sol";
import {IHookHandler} from "../interfaces/IHookHandler.sol";
import {PositionLib} from "../libraries/PositionLib.sol";

abstract contract BaseReaction is IHookHandler, System {
  function _physics() internal view returns (IWorldPhysics) {
    return IWorldPhysics(_world());
  }

  function _getPosition(bytes32 entity)
    internal
    view
    returns (int128 x, int128 y)
  {
    PositionData memory position = Position.get(entity);
    return (position.x, position.y);
  }

  function _getEntitiesAtPosition(int128 x, int128 y)
    internal
    view
    returns (bytes32[] memory)
  {
    return PositionLib.getEntitiesAtPosition(x, y);
  }

  function _getOrientation(bytes32 entity)
    internal
    view
    returns (OrientationType)
  {
    return Orientation.get(entity);
  }

  function _getNetOrientation(bytes32 entity, DirectionType direction)
    internal
    view
    returns (OrientationType moveOrientation)
  {
    OrientationType baseOrientation = _getOrientation(entity);
    moveOrientation =
      OrientationType((uint8(baseOrientation) + uint8(direction)) % 4);
  }
}
