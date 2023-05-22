// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {SignedMath} from "@openzeppelin/contracts/utils/math/SignedMath.sol";
import {IWorld} from "../codegen/world/IWorld.sol";
import {Cooldown} from "../codegen/tables/Cooldown.sol";
import {MoveStat} from "../codegen/tables/MoveStat.sol";
import {MoveCommitment} from "../codegen/tables/MoveCommitment.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {TypeLib} from "../libraries/TypeLib.sol";
import {AuthedCooldownSystem} from "./AuthedCooldownSystem.sol";

/**
 * @notice A system that allows an entity to move
 */
contract CommitMoveSystem is AuthedCooldownSystem {
  using SignedMath for int128;
  using TypeLib for bytes32;

  function commitMove(bytes32 entity, bytes32 commitment)
    external
    onlyApproved(entity)
    cooldownReady(entity)
  {
    require(MoveCommitment.get(entity) == 0, "Move already committed");
    MoveCommitment.set(entity, commitment);
    Cooldown.setEndsAt(entity, uint40(block.timestamp));
  }

  /**
   * @notice Reveal a move and update the entity's position
   * @param entity The entity to move
   * @param x The new x position
   * @param y The new y position
   * @param salt The salt used to commit the move
   */
  function revealMove(bytes32 entity, int128 x, int128 y, bytes32 salt)
    external
    cooldownReady(entity)
  {
    _verifySalt(entity, x, y, salt);
    _verifyPosition(entity, x, y);
    IWorld(_world())._move(entity, x, y);
  }

  function _verifySalt(bytes32 entity, int128 x, int128 y, bytes32 salt)
    internal
    view
  {
    require(
      MoveCommitment.get(entity) == keccak256(abi.encodePacked(x, y, salt)),
      "Invalid salt"
    );
  }

  function _verifyPosition(bytes32 entity, int128 x, int128 y) internal view {
    require(
      PositionLib.withinDistance(
        entity, x, y, MoveStat.getMaxDistance(TypeLib.get(entity))
      ),
      "Move distance too far"
    );
  }
}
