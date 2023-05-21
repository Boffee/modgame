// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Balance} from "../codegen/tables/Balance.sol";
import {TotalSupply} from "../codegen/tables/TotalSupply.sol";
import {Owner} from "../codegen/tables/Owner.sol";
import {TypeCast} from "../libraries/TypeCast.sol";

library ERC721Logic {
  using TypeCast for bytes32;
  using TypeCast for address;

  /**
   * @dev Mints `tokenId` to `to`
   * @param token token to mint
   * @param to entity to mint token to
   * @param tokenId token id to mint
   */
  function _mint(bytes32 token, address to, uint256 tokenId) internal {
    require(to != address(0), "ERC721: mint to the zero entity");
    bytes32 entity = token.toBytes32(tokenId);
    require(!_exists(entity), "ERC721: token already minted");

    bytes32 _to = to.toBytes32();

    Balance.set(token, _to, Balance.get(token, _to) + 1);
    TotalSupply.set(token, TotalSupply.get(token) + 1);

    Owner.set(token, to);
  }

  /**
   * @dev Transfers `tokenId` from `from` to `to`
   * @param token token to transfer
   * @param from entity to transfer token from
   * @param to entity to transfer token to
   * @param tokenId token id to transfer
   */
  function _transfer(bytes32 token, address from, address to, uint256 tokenId)
    internal
  {
    bytes32 entity = token.toBytes32(tokenId);

    require(_ownerOf(entity) == from, "ERC721: transfer from incorrect owner");
    require(to != address(0), "ERC721: transfer to the zero address");
    require(Owner.get(token) == from, "ERC721: transfer from incorrect owner");

    // TODO: clear approval once implemented

    bytes32 _from = from.toBytes32();
    bytes32 _to = to.toBytes32();

    Balance.set(token, _from, Balance.get(token, _from) - 1);
    Balance.set(token, _to, Balance.get(token, _to) + 1);

    Owner.set(token, to);
  }

  /**
   * @dev Burns `tokenId`
   * @param token token to burn
   * @param tokenId token id to burn
   */
  function _burn(bytes32 token, uint256 tokenId) internal {
    bytes32 entity = token.toBytes32(tokenId);
    address owner = _ownerOf(entity);
    bytes32 _owner = owner.toBytes32();

    // TODO: clear approvals once implemented

    Balance.set(token, _owner, Balance.get(token, _owner) - 1);
    TotalSupply.set(token, TotalSupply.get(token) - 1);

    Owner.deleteRecord(token);
  }

  function _exists(bytes32 entity) internal view returns (bool) {
    return _ownerOf(entity) != address(0);
  }

  function _ownerOf(bytes32 entity) internal view returns (address) {
    return Owner.get(entity);
  }
}
