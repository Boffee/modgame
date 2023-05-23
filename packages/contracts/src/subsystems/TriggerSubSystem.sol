// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {EntityHookSystem} from "../extensions/EntityHookSystem.sol";
import {ON_TRIGGER} from "../constants.sol";

contract TriggerSubSystem is EntityHookSystem {
  function _trigger(bytes32 source, bytes32 target) public {
    _callHook(ON_TRIGGER, source, target);
  }
}
