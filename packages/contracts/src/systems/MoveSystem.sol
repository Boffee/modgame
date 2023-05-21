// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {SignedMath} from "@openzeppelin/contracts/utils/math/SignedMath.sol";
import {CreatureStats} from "../codegen/tables/CreatureStats.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {AuthedCooldownSystem} from "./AuthedCooldownSystem.sol";

/**
 * @notice A system that allows an entity to move
 */
contract MoveSystem is AuthedCooldownSystem {
  using SignedMath for int128;

  /**
   * @notice Move an entity to a new position
   * @param entity The entity to move
   * @param x The new x position
   * @param y The new y position
   */
  function move(bytes32 entity, int128 x, int128 y)
    external
    onlyApproved(entity)
    cooldownReady(entity)
  {
    _verifyPosition(entity, x, y);
    Position.set(entity, PositionData({x: x, y: y}));
    _setCooldown(entity, CreatureStats.getMoveCooldown(entity));
  }

  function _verifyPosition(bytes32 entity, int128 x, int128 y) internal view {
    PositionData memory currPosition = Position.get(entity);
    require(
      (currPosition.x - x).abs() + (currPosition.y - y).abs()
        <= CreatureStats.getMoveDistance(entity),
      "Move distance too far"
    );
  }
}
