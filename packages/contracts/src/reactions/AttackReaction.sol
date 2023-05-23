// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {BaseReaction} from "./BaseReaction.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";

abstract contract AttackBase is BaseReaction {
  function _attack(bytes32 entity, DirectionType direction, int128 distance)
    internal
  {
    OrientationType orientation = _getNetOrientation(entity, direction);
    (int128 x, int128 y) = _getPosition(entity);
    bytes32[] memory entities;
    if (orientation == OrientationType.North) {
      entities = _getEntitiesAtPosition(x, y + distance);
    } else if (orientation == OrientationType.East) {
      entities = _getEntitiesAtPosition(x + distance, y);
    } else if (orientation == OrientationType.South) {
      entities = _getEntitiesAtPosition(x, y - distance);
    } else if (orientation == OrientationType.West) {
      entities = _getEntitiesAtPosition(x - distance, y);
    }

    for (uint256 i = 0; i < entities.length; i++) {
      _physics()._attack(entity, entities[i]);
    }
  }
}

contract AttackForward1 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 1);
  }
}

contract AttackForward2 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 2);
  }
}

contract AttackForward4 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 4);
  }
}

contract AttackRight1 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Right, 1);
  }
}

contract AttackRight2 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Right, 2);
  }
}

contract AttackRight4 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Right, 4);
  }
}

contract AttackBackward1 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Backward, 1);
  }
}

contract AttackBackward2 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Backward, 2);
  }
}

contract AttackBackward4 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Backward, 4);
  }
}

contract AttackLeft1 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Left, 1);
  }
}

contract AttackLeft2 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Left, 2);
  }
}

contract AttackLeft4 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Left, 4);
  }
}

contract AttackRandom is AttackBase {
  function execute(bytes32 source, bytes32) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _attack(source, direction, distance);
  }
}

contract AttackWithin1 is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 1);
    _attack(source, DirectionType.Right, 1);
    _attack(source, DirectionType.Backward, 1);
    _attack(source, DirectionType.Left, 1);
  }
}
