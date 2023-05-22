// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface HookHandlerProxySubSystem {
  function hook_HandlerProxy_execute(
    bytes32 hookType,
    bytes32 source,
    bytes32 target
  ) external;
}
