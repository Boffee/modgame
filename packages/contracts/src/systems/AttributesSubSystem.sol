// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {getUniqueEntity} from
  "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import {AttackStat, AttackStatData} from "../codegen/tables/AttackStat.sol";
import {MoveStat, MoveStatData} from "../codegen/tables/MoveStat.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {Immutable} from "../codegen/tables/Immutable.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";

contract AttributesSubSystem is AuthedSystem {
  /**
   * @notice Create a new type and define its attributes
   * @param owner the owner of the type
   * @param type_ the type entity
   * @param attackDist maximum attack distance
   * @param attackCD attack cooldown
   * @param moveDist maximum move distance
   * @param moveCD move cooldown
   */
  function _createAndDefineType(
    address owner,
    bytes32 type_,
    uint32 attackDist,
    uint32 attackCD,
    uint32 moveDist,
    uint32 moveCD
  ) public {
    _createType(owner, type_);
    _defineType(type_, attackDist, attackCD, moveDist, moveCD);
  }

  /**
   * @notice Define a type
   * @dev type cannot be redefined
   * @param type_ the type entity
   * @param attackDist maximum attack distance
   * @param attackCD attack cooldown
   * @param moveDist maximum move distance
   * @param moveCD move cooldown
   */
  function _defineType(
    bytes32 type_,
    uint32 attackDist,
    uint32 attackCD,
    uint32 moveDist,
    uint32 moveCD
  ) public onlyApproved(type_) {
    require(!Immutable.get(type_), "Type is immutable");

    AttackStat.set(
      type_, AttackStatData({maxDistance: attackDist, cooldown: attackCD})
    );
    MoveStat.set(type_, MoveStatData({maxDistance: moveDist, cooldown: moveCD}));
  }

  /**
   * @notice Create a new type with no attributes
   * @param owner the owner of the type
   * @param type_ the type entity
   */
  function _createType(address owner, bytes32 type_) public {
    require(Owner.get(type_) == address(0), "Type already defined");
    Owner.set(type_, owner);
  }
}
