// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface IAttackedHandler {
  function attacked(bytes32 source, bytes32 target) external;
}
