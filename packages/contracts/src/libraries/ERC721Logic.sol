// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Balance} from "../codegen/tables/Balance.sol";
import {TotalSupply} from "../codegen/tables/TotalSupply.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {Token} from "../codegen/tables/Token.sol";
import {Id} from "../codegen/tables/Id.sol";
import {TypeCast} from "../libraries/TypeCast.sol";

library ERC721Logic {
  using TypeCast for bytes32;
  using TypeCast for address;

  function _mint(address to, bytes32 token) internal {
    _mint(token, to.toBytes32(), TotalSupply.get(token));
  }

  function _mint(bytes32 to, bytes32 token) internal {
    _mint(token, to, TotalSupply.get(token));
  }

  /**
   * @dev Mints `tokenId` to `to`
   * @param token token to mint
   * @param to entity to mint token to
   * @param tokenId token id to mint
   */
  function _mint(bytes32 token, bytes32 to, uint256 tokenId) internal {
    require(to != bytes32(0), "ERC721: mint to the zero entity");
    bytes32 entity = token.toBytes32(tokenId);
    require(!_exists(entity), "ERC721: token already minted");

    Balance.set(token, to, Balance.get(token, to) + 1);
    TotalSupply.set(token, TotalSupply.get(token) + 1);
    Token.set(entity, token);
    Id.set(entity, tokenId);

    Owner.set(token, to);
  }

  /**
   * @dev Transfers `tokenId` from `from` to `to`
   * @param token token to transfer
   * @param from entity to transfer token from
   * @param to entity to transfer token to
   * @param tokenId token id to transfer
   */
  function _transfer(bytes32 token, bytes32 from, bytes32 to, uint256 tokenId)
    internal
  {
    bytes32 entity = token.toBytes32(tokenId);

    require(_ownerOf(entity) == from, "ERC721: transfer from incorrect owner");
    require(to != bytes32(0), "ERC721: transfer to the zero entity");
    require(Owner.get(token) == from, "ERC721: transfer from incorrect owner");

    // TODO: clear approval once implemented

    Balance.set(token, from, Balance.get(token, from) - 1);
    Balance.set(token, to, Balance.get(token, to) + 1);

    Owner.set(token, to);
  }

  /**
   * @dev Burns `tokenId`
   * @param token token to burn
   * @param tokenId token id to burn
   */
  function _burn(bytes32 token, uint256 tokenId) internal {
    bytes32 entity = token.toBytes32(tokenId);
    bytes32 owner = _ownerOf(entity);

    // TODO: clear approvals once implemented

    Balance.set(token, owner, Balance.get(token, owner) - 1);
    TotalSupply.set(token, TotalSupply.get(token) - 1);

    Owner.deleteRecord(token);
  }

  function _exists(bytes32 entity) internal view returns (bool) {
    return _ownerOf(entity) != bytes32(0);
  }

  function _ownerOf(bytes32 entity) internal view returns (bytes32) {
    return Owner.get(entity);
  }
}
