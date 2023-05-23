// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {EntityHookSystem} from "../extensions/EntityHookSystem.sol";
import {ON_TRIGGER} from "../constants.sol";

contract TriggerSystem is AuthedSystem, EntityHookSystem {
  function trigger(bytes32 source, bytes32 target) public onlyApproved(source) {
    _callHook(ON_TRIGGER, source, target);
  }
}
