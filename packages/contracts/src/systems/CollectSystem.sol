// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Balance} from "../codegen/tables/Balance.sol";
import {GoldSpawnLogic} from "../libraries/GoldSpawnLogic.sol";
import {ItemSpawnLogic} from "../libraries/ItemSpawnLogic.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {ITEM_TOKEN} from "../constants.sol";

contract CollectSystem is AuthedSystem {
  function collectGold(uint256 seed, bytes32 to) public onlyApproved(to) {
    require(Balance.get(ITEM_TOKEN, to) < 3, "inventory full");
    GoldSpawnLogic.collect(seed, to);
  }

  function collectItem(uint256 seed, bytes32 to) public onlyApproved(to) {
    ItemSpawnLogic.collect(seed, to);
  }
}
