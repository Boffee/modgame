// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {SignedMath} from "@openzeppelin/contracts/utils/math/SignedMath.sol";
import {IWorld} from "../codegen/world/IWorld.sol";
import {MoveStat} from "../codegen/tables/MoveStat.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {OrientationType} from "../codegen/Types.sol";
import {GoldSpawnLogic} from "../libraries/GoldSpawnLogic.sol";
import {ItemSpawnLogic} from "../libraries/ItemSpawnLogic.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {TypeLib} from "../libraries/TypeLib.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {CooldownSystem} from "../extensions/CooldownSystem.sol";

/**
 * @notice A system that allows an entity to move
 */
contract MoveSystem is AuthedSystem, CooldownSystem {
  using SignedMath for int128;
  using TypeLib for bytes32;

  /**
   * @notice Move an entity to a new position
   * @param entity The entity to move
   * @param x The new x position
   * @param y The new y position
   */
  function move(
    bytes32 entity,
    int128 x,
    int128 y,
    uint256[] memory goldBlockNumbers,
    uint256[] memory itemBlockNumbers
  ) public onlyApproved(entity) cooldownReady(entity) {
    _verifyPosition(entity, x, y);
    _setCooldown(entity, MoveStat.getCooldown(TypeLib.get(entity)));
    IWorld(_world())._move(entity, x, y);
    _collectGold(goldBlockNumbers, entity);
    _collectItem(itemBlockNumbers, entity);
  }

  function _collectGold(uint256[] memory seedBlockNumbers, bytes32 owner)
    internal
  {
    for (uint256 i = 0; i < seedBlockNumbers.length; i++) {
      // TODO: replace with blockHash and enable check
      // require(seedBlockNumbers[i] > block.number - 256, "expired");
      GoldSpawnLogic.collect(seedBlockNumbers[i], owner);
    }
  }

  function _collectItem(uint256[] memory seedBlockNumbers, bytes32 owner)
    internal
  {
    for (uint256 i = 0; i < seedBlockNumbers.length; i++) {
      require(seedBlockNumbers[i] > block.number - 256, "expired");
      // TODO: replace with blockHash and enable check
      // require(seedBlockNumbers[i] > block.number - 256, "expired");
      ItemSpawnLogic.collect(seedBlockNumbers[i], owner);
    }
  }

  function moveRelative(
    bytes32 entity,
    int128 xDist,
    int128 yDist,
    uint256[] memory goldBlockNumbers,
    uint256[] memory itemBlockNumbers
  ) public {
    move(
      entity,
      Position.getX(entity) + xDist,
      Position.getY(entity) + yDist,
      goldBlockNumbers,
      itemBlockNumbers
    );
  }

  function turn(bytes32 entity, OrientationType orientation)
    external
    onlyApproved(entity)
  {
    IWorld(_world())._turn(entity, orientation);
  }

  function _verifyPosition(bytes32 entity, int128 x, int128 y) internal view {
    uint256 distance = PositionLib.distance(entity, x, y);
    require(distance <= 10, "Move distance too far");
    require(distance > 0, "Already at position");
  }
}
