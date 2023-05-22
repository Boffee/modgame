// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {getUniqueEntity} from
  "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import {AttackStat, AttackStatData} from "../codegen/tables/AttackStat.sol";
import {MoveStat, MoveStatData} from "../codegen/tables/MoveStat.sol";
import {Owner} from "../codegen/tables/Owner.sol";

contract AttributesSubSystem is System {
  /**
   * @notice Define a new type of entity
   * @dev type cannot be redefined
   * @param owner the owner of the type
   * @param attackDist maximum attack distance
   * @param attackCD attack cooldown
   * @param moveDist maximum move distance
   * @param moveCD move cooldown
   * @return entity the new type
   */
  function _defineType(
    address owner,
    uint32 attackDist,
    uint32 attackCD,
    uint32 moveDist,
    uint32 moveCD
  ) public returns (bytes32 entity) {
    entity = _createType(owner);
    AttackStat.set(
      entity, AttackStatData({maxDistance: attackDist, cooldown: attackCD})
    );
    MoveStat.set(
      entity, MoveStatData({maxDistance: moveDist, cooldown: moveCD})
    );
  }

  /**
   * @notice Create a new entity with no attributes
   * @dev cannot define type after calling _createType
   * @param owner the owner of the entity
   * @return entity the new entity
   */
  function _createType(address owner) public returns (bytes32 entity) {
    entity = getUniqueEntity();
    Owner.set(entity, owner);
  }
}
