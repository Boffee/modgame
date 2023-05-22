// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {getUniqueEntity} from
  "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import {AttackStat, AttackStatData} from "../codegen/tables/AttackStat.sol";
import {MoveStat, MoveStatData} from "../codegen/tables/MoveStat.sol";
import {Owner} from "../codegen/tables/Owner.sol";

contract AttributesSubSystem is System {
  function _defineType(
    address owner,
    uint32 attackDist,
    uint32 attackCD,
    uint32 moveDist,
    uint32 moveCD
  ) external returns (bytes32 entity) {
    entity = getUniqueEntity();
    AttackStat.set(
      entity, AttackStatData({maxDistance: attackDist, cooldown: attackCD})
    );
    MoveStat.set(
      entity, MoveStatData({maxDistance: moveDist, cooldown: moveCD})
    );
    Owner.set(entity, owner);
  }
}
