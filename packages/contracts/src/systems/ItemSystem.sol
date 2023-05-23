// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {Orientation} from "../codegen/tables/Orientation.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {OrientationType} from "../codegen/Types.sol";
import {ERC721Logic} from "../libraries/ERC721Logic.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {NULL} from "../constants.sol";

contract ItemSystem is AuthedSystem {
  function pickUp(bytes32 entity, bytes32 owner) external {
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
  ) external {
    require(PositionLib.withinDistance(entity, x, y, 1), "too far away");
    ERC721Logic._transfer(entity, owner, NULL);
    Position.setX(entity, x);
    Position.setY(entity, y);
    Orientation.set(entity, orientation);
  }

  function transfer(bytes32 entity, bytes32 from, bytes32 to) external {
    require(PositionLib.withinDistance(from, to, 1), "too far away");
    ERC721Logic._transfer(entity, from, to);
  }
}
