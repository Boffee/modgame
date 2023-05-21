// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Balance} from "../codegen/tables/Balance.sol";
import {TotalSupply} from "../codegen/tables/TotalSupply.sol";

library ERC20Logic {
  /**
   * @dev Mints `amount` tokens to `entity`
   * @param token token to mint
   * @param entity entity to mint tokens to
   * @param amount amount of tokens to mint
   */
  function _mint(bytes32 token, bytes32 entity, uint256 amount) internal {
    require(entity != 0, "ERC20: mint to the zero address");

    TotalSupply.set(token, TotalSupply.get(token) + amount);

    Balance.set(token, entity, Balance.get(token, entity) + amount);
  }

  /**
   * @dev Transfers `amount` tokens from `from` to `to`
   * @param token token to transfer
   * @param from entity to transfer tokens from
   * @param to entity to transfer tokens to
   * @param amount amount of tokens to transfer
   */
  function _transfer(bytes32 token, bytes32 from, bytes32 to, uint256 amount)
    internal
  {
    require(from != 0, "ERC20: transfer from the zero address");
    require(to != 0, "ERC20: transfer to the zero address");

    uint256 fromBalance = Balance.get(token, from);
    require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");

    Balance.set(token, from, fromBalance - amount);
    Balance.set(token, to, Balance.get(token, to) + amount);
  }

  /**
   * @dev Burns `amount` tokens from `entity`
   * @param token token to burn
   * @param entity entity to burn tokens from
   * @param amount amount of tokens to burn
   */
  function _burn(bytes32 token, bytes32 entity, uint256 amount) internal {
    require(entity != 0, "ERC20: burn from the zero address");

    uint256 entityBalance = Balance.get(token, entity);
    require(entityBalance >= amount, "ERC20: burn amount exceeds balance");

    Balance.set(token, entity, entityBalance - amount);
    TotalSupply.set(token, TotalSupply.get(token) - amount);
  }
}
