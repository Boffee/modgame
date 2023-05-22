// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {AuthedSystem} from "./AuthedSystem.sol";
import {EntityHookSystem} from "./EntityHookSystem.sol";
import {TRIGGER} from "../constants.sol";

contract TriggerSystem is AuthedSystem, EntityHookSystem {
  function trigger(bytes32 source, bytes32 target) public onlyApproved(source) {
    _callHook(TRIGGER, source, target);
  }
}
