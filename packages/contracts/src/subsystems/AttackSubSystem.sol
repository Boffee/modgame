// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {getKeysWithValue} from
  "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";
import {
  Position,
  PositionData,
  PositionTableId
} from "../codegen/tables/Position.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {Predation} from "../codegen/tables/Predation.sol";
import {Id} from "../codegen/tables/Id.sol";
import {Token} from "../codegen/tables/Token.sol";
import {PositionLib} from "../libraries/PositionLib.sol";
import {TypeLib} from "../libraries/TypeLib.sol";
import {ERC721Logic} from "../libraries/ERC721Logic.sol";
import {EntityHookSystem} from "../extensions/EntityHookSystem.sol";
import {ON_ATTACK, ON_HIT, ON_KILL, PLAYER_TOKEN} from "../constants.sol";

contract AttackSubSystem is EntityHookSystem {
  using TypeLib for bytes32;

  function _attack(bytes32 source, bytes32 target) public {
    _callHook(ON_ATTACK, source, target);

    bool isPredator = Predation.get(source, target);
    bool isPrey = Predation.get(target, source);

    _callHook(ON_HIT, source, target);

    if (isPredator && !isPrey) {
      _kill(source, target);
    } else if (isPrey && !isPredator) {
      _kill(target, source);
    } else {
      _die(target);
      _die(source);
      _callHook(ON_KILL, source, target);
      _callHook(ON_KILL, target, source);
    }
  }

  function _kill(bytes32 source, bytes32 target) public {
    _verifyPosition(source, target);
    _die(target);
    _callHook(ON_KILL, source, target);
    // TODO: handle item pickup
  }

  function _die(bytes32 entity) internal {
    // TODO: handle item drops
    _remove(entity);
  }

  function _remove(bytes32 entity) internal {
    bytes32 token = Token.get(entity);
    if (token != bytes32(0)) {
      ERC721Logic._burn(token, Id.get(entity));
    } else {
      Owner.deleteRecord(entity);
    }
    Position.deleteRecord(entity);
  }

  function _verifyPosition(bytes32 entity, bytes32 target) internal view {
    // TODO: replace hardcoded range
    require(PositionLib.distance(entity, target) <= 5, "Target too far");
  }
}
