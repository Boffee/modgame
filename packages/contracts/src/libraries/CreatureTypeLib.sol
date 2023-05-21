// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {
  CreatureMutation,
  CreatureMutationData
} from "../codegen/tables/CreatureMutation.sol";
import {CreatureType} from "../codegen/tables/CreatureType.sol";

library CreatureTypeLib {
  function get(bytes32 entity) internal view returns (bytes32) {
    CreatureMutationData memory mutation = CreatureMutation.get(entity);
    return mutation.endsAt > block.timestamp
      ? CreatureType.get(entity)
      : mutation.creature;
  }
}
