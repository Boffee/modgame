// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {Balance} from "../codegen/tables/Balance.sol";
import {PLAYER_TOKEN} from "../constants.sol";
import {TypeCast} from "../libraries/TypeCast.sol";
import {ERC721Logic} from "../libraries/ERC721Logic.sol";

contract SpawnSystem is System {
  using TypeCast for address;

  function spawn() external {
    require(
      Balance.get(PLAYER_TOKEN, _msgSender().toBytes32()) == 0,
      "already playing"
    );

    ERC721Logic._mint(_msgSender(), PLAYER_TOKEN);
  }
}
