// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {Owner} from "../codegen/tables/Owner.sol";

/**
 * @notice A system that requires the sender to be the owner of the entity or
 * approved to perform an action on the entity.
 */
contract AuthedSystem is System {
  /**
   * @notice Checks if the sender is the owner of the entity
   * @param entity The entity to check
   */
  modifier onlyOwner(bytes32 entity) {
    require(_isOwner(entity), "Not owner");
    _;
  }

  /**
   * @notice Checks if the sender is approved to perform an action on the entity
   * @param entity The entity to check
   */
  modifier onlyApproved(bytes32 entity) {
    require(_isApproved(entity), "Not approved");
    _;
  }

  /**
   * @notice Checks if the sender is the owner of the entity
   * @param entity The entity to check
   * @return True if the sender is the owner of the entity, false otherwise
   */
  function _isOwner(bytes32 entity) internal view returns (bool) {
    return Owner.get(entity) == msg.sender;
  }

  /**
   * @notice Checks if the sender is approved to perform an action on the entity
   * @param entity The entity to check
   * @return True if the sender is approved, false otherwise
   */
  function _isApproved(bytes32 entity) internal view returns (bool) {
    // TODO: implement approval system
    return _isOwner(entity);
  }
}
