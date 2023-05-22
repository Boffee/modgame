// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IAttributesSubSystem {
  function _defineType(
    address owner,
    uint32 attackDist,
    uint32 attackCD,
    uint32 moveDist,
    uint32 moveCD
  ) external returns (bytes32 entity);
}