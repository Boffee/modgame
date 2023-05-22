// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface IHookHandler {
  function execute(bytes32 source, bytes32 target) external;
}
