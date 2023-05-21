// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Mutation, MutationData} from "../codegen/tables/Mutation.sol";
import {Creature} from "../codegen/tables/Creature.sol";
import {CreatureStats} from "../codegen/tables/CreatureStats.sol";

library CreatureLib {
  function get(bytes32 entity) internal view returns (bytes32) {
    MutationData memory mutation = Mutation.get(entity);
    return mutation.endsAt > block.timestamp
      ? Creature.get(entity)
      : mutation.creature;
  }
}
