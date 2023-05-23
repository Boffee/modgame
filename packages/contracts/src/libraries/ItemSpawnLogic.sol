// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {ModList} from "../codegen/tables/ModList.sol";
import {Type} from "../codegen/tables/Type.sol";
import {Collected} from "../codegen/tables/Collected.sol";
import {Balance} from "../codegen/tables/Balance.sol";
import {ERC721Logic} from "../libraries/ERC721Logic.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {TypeCast} from "../libraries/TypeCast.sol";
import {ITEM_TOKEN} from "../constants.sol";

library ItemSpawnLogic {
  using TypeCast for bytes32;

  function collect(uint256 seed, bytes32 to) internal {
    bytes32 key = keccak256(abi.encode(ITEM_TOKEN, seed));
    // TODO: re-enable require
    // require(!Collected.get(key), "already collected");
    if (Collected.get(key) || Balance.get(ITEM_TOKEN, to) >= 3) return;

    (int128 x, int128 y, bytes32 item) = getItemSpawn(uint256(seed));
    require(PositionLib.collocated(to, x, y), "not collocated");

    mintItem(item, to);
    // TODO: better way to do this? This is a waste of storage
    Collected.set(key, true);
  }

  function mintItem(bytes32 itemType, bytes32 to)
    internal
    returns (bytes32 item)
  {
    uint256 tokenId = ERC721Logic._mint(ITEM_TOKEN, to);
    Type.set(item, itemType);
    return ERC721Logic.toEntity(ITEM_TOKEN, tokenId);
  }

  function getItemSpawn(uint256 seed)
    internal
    view
    returns (int128 x, int128 y, bytes32 itemType)
  {
    (x, y) = samplePosition(seed);
    itemType = sampleItemType(seed);
  }

  function samplePosition(uint256 seed)
    internal
    pure
    returns (int128 x, int128 y)
  {
    int256 rng = int256(random(seed));
    x = int128(rng % 1000 - 500);
    y = int128(rng / 1000 - 500);
  }

  function sampleItemType(uint256 seed) internal view returns (bytes32) {
    return ModList.getItem(random(seed) % ModList.length());
  }

  function random(uint256 seed) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(seed)));
  }
}
