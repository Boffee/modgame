// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {CreatureStats} from "../codegen/tables/CreatureStats.sol";
import {Cooldown, CooldownData} from "../codegen/tables/Cooldown.sol";
import {CreatureLib} from "../libraries/CreatureLib.sol";
import {AuthedSystem} from "./AuthedSystem.sol";

/**
 * @notice A system that requires an entity to be off cooldown. Cooldown is
 * used to prevent spamming and front-running of actions.
 *
 * We also give players a small cooldown reserve which accumulates for duration
 * at rest after the cooldown is up. The reserve reduces the cooldown of the
 * subsequent action by the reserve amount. This is meant to prevent bots with
 * perfect timing from having an advantage over human players.
 */
contract AuthedCooldownSystem is AuthedSystem {
  /**
   * @notice Checks if the entity is off cooldown
   * @param entity The entity to check
   */
  modifier cooldownReady(bytes32 entity) {
    require(_isCooldownReady(entity), "Cooldown not ready");
    _;
  }

  function _isCooldownReady(bytes32 entity) internal view returns (bool) {
    CooldownData memory cooldown = Cooldown.get(entity);
    return cooldown.readyAt - cooldown.reserve <= block.timestamp;
  }

  /**
   * @notice Sets the cooldown of an entity
   * @param entity The entity to set the cooldown of
   * @param duration The duration of the cooldown
   */
  function _setCooldown(bytes32 entity, uint40 duration) internal {
    CooldownData memory cooldown = Cooldown.get(entity);
    Cooldown.set(
      entity,
      CooldownData({
        readyAt: uint40(block.timestamp + duration),
        reserve: uint40(
          Math.min(
            CreatureStats.getCooldownReserveCapacity(CreatureLib.get(entity)),
            block.timestamp - cooldown.readyAt - cooldown.reserve
          )
          )
      })
    );
  }
}
