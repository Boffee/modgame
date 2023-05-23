// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { DirectionType, OrientationType } from "./../Types.sol";

interface IMoveSubSystem {
  function _moveRelative(bytes32 entity, int128 xDist, int128 yDist) external;

  function _move(bytes32 entity, int128 x, int128 y) external;

  function _turnRelative(bytes32 entity, DirectionType direction) external;

  function _turn(bytes32 entity, OrientationType orientation) external;

  function _traverse(bytes32 entity, uint256 directions) external;
}
