// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IWorld} from "../codegen/world/IWorld.sol";
import {Immutable} from "../codegen/tables/Immutable.sol";
import {Name} from "../codegen/tables/Name.sol";
import {Description} from "../codegen/tables/Description.sol";
import {ImageUri} from "../codegen/tables/ImageUri.sol";
import {AuthedSystem} from "../extensions/AuthedSystem.sol";
import {MutableSystem} from "../extensions/MutableSystem.sol";

contract MetadataSystem is AuthedSystem, MutableSystem {
  function setName(bytes32 entity, string memory name)
    external
    onlyApproved(entity)
    onlyMutable(entity)
  {
    Name.set(entity, name);
  }

  function setDescription(bytes32 entity, string memory description)
    external
    onlyApproved(entity)
  {
    Description.set(entity, description);
  }

  function setImageUri(bytes32 entity, string memory imageUri)
    external
    onlyApproved(entity)
    onlyMutable(entity)
  {
    ImageUri.set(entity, imageUri);
  }
}
