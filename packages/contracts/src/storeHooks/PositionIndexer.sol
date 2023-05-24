// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/console2.sol";
import {IStore, IStoreHook} from "@latticexyz/store/src/IStore.sol";
import {ArrayLib} from "@latticexyz/world/src/modules/utils/ArrayLib.sol";
import {AtPosition} from "../codegen/tables/AtPosition.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";

contract PositionIndexer is IStoreHook {
  using ArrayLib for bytes32[];

  function onSetRecord(bytes32, bytes32[] memory key, bytes memory data) public {
    PositionData memory prevPosition = Position.get(key[0]);
    PositionData memory position = Position.decode(data);

    if (prevPosition.x == position.x && prevPosition.y == position.y) return;

    _remove(key);

    AtPosition.push(position.x, position.y, key[0]);
  }

  function onBeforeSetField(bytes32, bytes32[] memory key, uint8, bytes memory)
    external
  {
    _remove(key);
  }

  function onAfterSetField(bytes32, bytes32[] memory key, uint8, bytes memory)
    public
  {
    PositionData memory position = Position.get(key[0]);
    AtPosition.push(position.x, position.y, key[0]);
  }

  function onDeleteRecord(bytes32, bytes32[] memory key) public {
    _remove(key);
  }

  function _remove(bytes32[] memory key) internal {
    PositionData memory position = Position.get(key[0]);

    // will fail if AtPosition is empty because bytes32(0) is a valid key
    if (AtPosition.length(position.x, position.y) == 0) return;

    bytes32[] memory keysWithPreviousValue =
      AtPosition.get(position.x, position.y).filter(key[0]);

    if (keysWithPreviousValue.length == 0) {
      AtPosition.deleteRecord(position.x, position.y);
    } else {
      AtPosition.set(position.x, position.y, keysWithPreviousValue);
    }
  }
}
