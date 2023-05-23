// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { IBaseWorld } from "@latticexyz/world/src/interfaces/IBaseWorld.sol";

import { IAttackSubSystem } from "./IAttackSubSystem.sol";
import { IAttributesSubSystem } from "./IAttributesSubSystem.sol";
import { IHookHandlerProxySubSystem } from "./IHookHandlerProxySubSystem.sol";
import { IMoveSubSystem } from "./IMoveSubSystem.sol";
import { ITriggerSubSystem } from "./ITriggerSubSystem.sol";
import { IAttackSystem } from "./IAttackSystem.sol";
import { ICollectSystem } from "./ICollectSystem.sol";
import { ICommitMoveSystem } from "./ICommitMoveSystem.sol";
import { IItemSystem } from "./IItemSystem.sol";
import { IModSystem } from "./IModSystem.sol";
import { IMoveSystem } from "./IMoveSystem.sol";
import { IPlayerSpawnSystem } from "./IPlayerSpawnSystem.sol";

/**
 * The IWorld interface includes all systems dynamically added to the World
 * during the deploy process.
 */
interface IWorld is
  IBaseWorld,
  IAttackSubSystem,
  IAttributesSubSystem,
  IHookHandlerProxySubSystem,
  IMoveSubSystem,
  ITriggerSubSystem,
  IAttackSystem,
  ICollectSystem,
  ICommitMoveSystem,
  IItemSystem,
  IModSystem,
  IMoveSystem,
  IPlayerSpawnSystem
{

}
