// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Mutation, MutationData} from "../codegen/tables/Mutation.sol";
import {Type} from "../codegen/tables/Type.sol";

library TypeLib {
  function get(bytes32 entity) internal view returns (bytes32) {
    MutationData memory mutation = Mutation.get(entity);
    return
      mutation.endsAt > block.timestamp ? Type.get(entity) : mutation.entityType;
  }
}
