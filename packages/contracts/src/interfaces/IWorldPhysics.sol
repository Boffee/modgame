// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IAttackSubSystem} from "../codegen/world/IAttackSubSystem.sol";
import {IAttributesSubSystem} from "../codegen/world/IAttributesSubSystem.sol";
import {IMoveSubSystem} from "../codegen/world/IMoveSubSystem.sol";
import {ITriggerSubSystem} from "../codegen/world/ITriggerSubSystem.sol";

interface IWorldPhysics is
  IAttackSubSystem,
  IAttributesSubSystem,
  IMoveSubSystem,
  ITriggerSubSystem
{}
