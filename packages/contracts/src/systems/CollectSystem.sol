// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Balance} from "../codegen/tables/Balance.sol";
import {GoldSpawnLogic} from "../libraries/GoldSpawnLogic.sol";
import {ItemSpawnLogic} from "../libraries/ItemSpawnLogic.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {ITEM_TOKEN, NULL} from "../constants.sol";

contract CollectSystem is AuthedSystem {
  // TODO: remove
  function mintItem(bytes32 itemType) external returns (bytes32) {
    return ItemSpawnLogic.mintItem(itemType, NULL);
  }

  function collectGold(uint256[] memory seedBlockNumbers, bytes32 to)
    external
    onlyApproved(to)
  {
    for (uint256 i = 0; i < seedBlockNumbers.length; i++) {
      // TODO: replace with blockHash and enable check
      // require(seedBlockNumbers[i] > block.number - 256, "expired");
      GoldSpawnLogic.collect(seedBlockNumbers[i], to);
    }
  }

  function collectItem(uint256[] memory seedBlockNumbers, bytes32 to)
    external
    onlyApproved(to)
  {
    for (uint256 i = 0; i < seedBlockNumbers.length; i++) {
      // TODO: replace with blockHash and enable check
      // require(seedBlockNumbers[i] > block.number - 256, "expired");
      ItemSpawnLogic.collect(seedBlockNumbers[i], to);
    }
  }
}
