// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {Position} from "../codegen/tables/Position.sol";
import {Type} from "../codegen/tables/Type.sol";
import {TypeCast} from "../libraries/TypeCast.sol";
import {PLAYER_TOKEN, RED, GREEN, BLUE} from "../constants.sol";

contract PlayerSpawnSystem is System {
  using TypeCast for address;

  function spawn(bytes32 type_, int128 x, int128 y) external {
    require(type_ == RED || type_ == GREEN || type_ == BLUE, "invalid type");
    bytes32 entity = _msgSender().toBytes32();
    require(Owner.get(entity) == bytes32(0), "already spawned");
    Owner.set(entity, entity);
    Type.set(entity, type_);
    Position.set(entity, x, y);
  }
}
