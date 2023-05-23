// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IWorld} from "../codegen/world/IWorld.sol";
import {Orientation} from "../codegen/tables/Orientation.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {OrientationType} from "../codegen/Types.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {ERC721Logic} from "../libraries/ERC721Logic.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {NULL, ON_TRIGGER} from "../constants.sol";

contract ItemSystem is AuthedSystem {
  function pickUp(bytes32 entity, bytes32 owner) external onlyApproved(owner) {
    require(Owner.get(entity) == NULL, "already owned");
    require(PositionLib.withinDistance(entity, owner, 1), "too far away");
    ERC721Logic._transfer(entity, NULL, owner);
    Position.deleteRecord(entity);
    Orientation.deleteRecord(entity);
  }

  function drop(
    bytes32 entity,
    bytes32 owner,
    int128 x,
    int128 y,
    OrientationType orientation
  ) external onlyApproved(owner) {
    require(PositionLib.withinDistance(owner, x, y, 1), "too far away");
    ERC721Logic._transfer(entity, owner, NULL);
    Position.setX(entity, x);
    Position.setY(entity, y);
    Orientation.set(entity, orientation);
  }

  function transfer(bytes32 entity, bytes32 from, bytes32 to)
    external
    onlyApproved(from)
  {
    require(PositionLib.withinDistance(from, to, 1), "too far away");
    ERC721Logic._transfer(entity, from, to);
  }

  function trigger(bytes32 source, bytes32 target, OrientationType orientation)
    public
    onlyApproved(source)
  {
    require(PositionLib.withinDistance(source, target, 1), "too far away");
    require(Owner.get(target) == NULL, "already owned");
    Orientation.set(target, orientation);
    IWorld(_world())._trigger(source, target);
  }

  function trigger(bytes32 source, bytes32 target) public onlyApproved(source) {
    require(PositionLib.withinDistance(source, target, 1), "too far away");
    IWorld(_world())._trigger(source, target);
  }
}
