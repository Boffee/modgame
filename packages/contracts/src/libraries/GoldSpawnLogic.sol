// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {ModList} from "../codegen/tables/ModList.sol";
import {Collected} from "../codegen/tables/Collected.sol";
import {ERC20Logic} from "../libraries/ERC20Logic.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {GOLD_TOKEN} from "../constants.sol";

library GoldSpawnLogic {
  function collect(uint256 seed, bytes32 to) internal {
    bytes32 key = keccak256(abi.encode(GOLD_TOKEN, seed));
    require(!Collected.get(key), "already collected");

    (int128 x, int128 y, uint256 amount) = getGoldSpawn(seed);
    require(PositionLib.collocated(to, x, y), "not collocated");
    mintGold(to, amount);
    // TODO: better way to do this? This is a waste of storage
    Collected.set(key, true);
  }

  function mintGold(bytes32 to, uint256 amount) internal {
    ERC20Logic._mint(GOLD_TOKEN, to, amount);
  }

  function getGoldSpawn(uint256 seed)
    internal
    pure
    returns (int128 x, int128 y, uint256 amount)
  {
    (x, y) = samplePosition(seed);
    amount = sampleAmount(seed);
  }

  function sampleAmount(uint256 seed) internal pure returns (uint256) {
    // TODO: enable sampling
    // return (random(seed) % 3) + 1;
    return 1;
  }

  function samplePosition(uint256 seed)
    internal
    pure
    returns (int128 x, int128 y)
  {
    uint256 rng = random(seed);
    x = int128(int256(rng % 1000) - 500);
    y = int128(int256((rng / 1000) % 1000) - 500);
  }

  function random(uint256 seed) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(seed)));
  }
}
