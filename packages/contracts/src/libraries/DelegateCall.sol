// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library DelegateCall {
  function functionDelegateCall(address to, bytes memory selectorAndArgs)
    internal
    returns (bytes memory)
  {
    (bool success, bytes memory returndata) = to.delegatecall(selectorAndArgs);
    if (success) {
      return returndata;
    } else {
      assembly {
        revert(add(32, returndata), mload(returndata))
      }
    }
  }
}
