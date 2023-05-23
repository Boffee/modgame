// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {HookHandler} from "../codegen/tables/HookHandler.sol";
import {IHookHandler} from "../interfaces/IHookHandler.sol";
import {DelegateCall} from "../libraries/DelegateCall.sol";
import {TypeLib} from "../libraries/TypeLib.sol";

contract HookHandlerProxySubSystem is System {
  using DelegateCall for address;

  function execute(bytes32 hookType, bytes32 source, bytes32 target) external {
    if (source == target) return;
    address handler = HookHandler.get(hookType, TypeLib.get(target));
    if (handler == address(0)) return;
    handler.functionDelegateCall(
      abi.encodeWithSelector(IHookHandler.execute.selector, source, target)
    );
  }
}
