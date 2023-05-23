// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Orientation} from "../codegen/tables/Orientation.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";
import {BaseReaction} from "./BaseReaction.sol";

abstract contract DirectionalReaction is BaseReaction {
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
