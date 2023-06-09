// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface ICommitMoveSystem {
  function commitMove(bytes32 entity, bytes32 commitment) external;

  function revealMove(bytes32 entity, int128 x, int128 y, bytes32 salt) external;
}
