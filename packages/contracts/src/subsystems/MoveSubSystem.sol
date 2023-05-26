// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {AtPosition} from "../codegen/tables/AtPosition.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {Orientation} from "../codegen/tables/Orientation.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";
import {TypeLib} from "../libraries/TypeLib.sol";
import {
  ON_ENTER,
  ON_LEAVE,
  ON_MOVE_START,
  ON_MOVE_END,
  NULL
} from "../constants.sol";
import {EntityHookSystem} from "../extensions/EntityHookSystem.sol";

/**
 * @notice A system that allows an entity to move
 */
contract MoveSubSystem is EntityHookSystem {
  using TypeLib for bytes32;

  function _moveRelative(bytes32 entity, int128 xDist, int128 yDist) public {
    _move(entity, Position.getX(entity) + xDist, Position.getY(entity) + yDist);
  }

  function _move(bytes32 entity, int128 x, int128 y) public {
    _callHook(ON_MOVE_START, entity, NULL);
    _callHooks(
      ON_LEAVE,
      entity,
      AtPosition.get(Position.getX(entity), Position.getY(entity))
    );

    Position.set(entity, x, y);

    _callHooks(ON_ENTER, entity, AtPosition.get(x, y));
    _callHook(ON_MOVE_END, entity, NULL);
  }

  function _turnRelative(bytes32 entity, DirectionType direction) public {
    Orientation.set(
      entity,
      OrientationType((uint8(Orientation.get(entity)) + uint8(direction)) % 4)
    );
  }

  function _turn(bytes32 entity, OrientationType orientation) public {
    Orientation.set(entity, orientation);
  }

  function _traverse(bytes32 entity, uint256 directions) external {
    int128 x = Position.getX(entity);
    int128 y = Position.getY(entity);

    uint256 length = 0xff & (directions >> 248);

    for (uint256 i = 0; i < length; i++) {
      _callHooks(ON_LEAVE, entity, AtPosition.get(x, y));

      uint256 direction = 3 & (directions >> (i * 2));
      if (direction == 0) {
        // up
        y -= 1;
      } else if (direction == 1) {
        // right
        x += 1;
      } else if (direction == 2) {
        // down
        y += 1;
      } else if (direction == 3) {
        // left
        x -= 1;
      }

      _callHooks(ON_ENTER, entity, AtPosition.get(x, y));
    }

    Position.set(entity, x, y);
  }
}
