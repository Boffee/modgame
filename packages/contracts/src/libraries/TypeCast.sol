// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library TypeCast {
  function toBytes32(address value) internal pure returns (bytes32) {
    return bytes32(uint256(uint160(value)));
  }

  function toAddress(bytes32 value) internal pure returns (address) {
    require(isAddress(value), "TypeCast: invalid address");
    return address(uint160(uint256(value)));
  }

  function toBytes32(uint256 value) internal pure returns (bytes32) {
    return bytes32(value);
  }

  function toUint256(bytes32 value) internal pure returns (uint256) {
    return uint256(value);
  }

  function toBytes32(address token, uint256 tokenId)
    internal
    pure
    returns (bytes32)
  {
    return keccak256(abi.encodePacked(token, tokenId));
  }

  function toBytes32(bytes32 token, uint256 tokenId)
    internal
    pure
    returns (bytes32)
  {
    return keccak256(abi.encodePacked(token, tokenId));
  }

  function isAddress(bytes32 value) internal pure returns (bool) {
    return value >> 160 == 0;
  }
}
