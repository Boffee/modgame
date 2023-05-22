// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {System} from "@latticexyz/world/src/System.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {HookHandler} from "../codegen/tables/HookHandler.sol";
import {IHookHandlerProxySubSystem} from "../codegen/world/IWorld.sol";
import {TypeLib} from "../libraries/TypeLib.sol";

contract EntityHookSystem is System {
  function _callHooks(
    bytes32 hookType,
    bytes32 source,
    bytes32[] memory targetEntities
  ) internal {
    for (uint256 i = 0; i < targetEntities.length; i++) {
      _callHook(hookType, source, targetEntities[i]);
    }
  }

  function _callHook(bytes32 hookType, bytes32 source, bytes32 target) internal {
    IHookHandlerProxySubSystem(_world()).execute(hookType, source, target);
  }

  function _call(bytes memory selectorAndArgs) internal {
    address world = _world();
    (bool success, bytes memory returnData) = world.call(selectorAndArgs);
    require(success, string(returnData));
  }
}
