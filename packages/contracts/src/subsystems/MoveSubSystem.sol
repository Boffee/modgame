// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {getKeysWithValue} from
  "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";

import {
  Position,
  PositionData,
  PositionTableId
} from "../codegen/tables/Position.sol";
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
      getKeysWithValue(
        PositionTableId,
        Position.encode(Position.getX(entity), Position.getY(entity))
      )
    );

    Position.setX(entity, x);
    Position.setY(entity, y);

    _callHooks(
      ON_ENTER, entity, getKeysWithValue(PositionTableId, Position.encode(x, y))
    );
    _callHook(ON_MOVE_END, entity, NULL);
  }

  function _traverse(bytes32 entity, uint256 directions) external {
    int128 x = Position.getX(entity);
    int128 y = Position.getY(entity);

    uint256 length = 0xff & (directions >> 248);

    bytes32[] memory targetEntities =
      getKeysWithValue(PositionTableId, Position.encode(x, y));
    for (uint256 i = 0; i < length; i++) {
      _callHooks(ON_LEAVE, entity, targetEntities);

      uint256 direction = 3 & (directions >> (i * 2));
      if (direction == 0) {
        // up
        y += 1;
      } else if (direction == 1) {
        // right
        x += 1;
      } else if (direction == 2) {
        // down
        y -= 1;
      } else if (direction == 3) {
        // left
        x -= 1;
      }

      targetEntities = getKeysWithValue(PositionTableId, Position.encode(x, y));
      _callHooks(ON_ENTER, entity, targetEntities);
    }

    Position.setX(entity, x);
    Position.setY(entity, y);
  }
}
