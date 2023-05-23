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

contract AttackForward1S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 1);
  }
}

contract AttackForward2S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 2);
  }
}

contract AttackForward4S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 4);
  }
}

contract AttackRight1S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Right, 1);
  }
}

contract AttackRight2S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Right, 2);
  }
}

contract AttackRight4S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Right, 4);
  }
}

contract AttackBackward1S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Backward, 1);
  }
}

contract AttackBackward2S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Backward, 2);
  }
}

contract AttackBackward4S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Backward, 4);
  }
}

contract AttackLeft1S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Left, 1);
  }
}

contract AttackLeft2S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Left, 2);
  }
}

contract AttackLeft4S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Left, 4);
  }
}

contract AttackRandomS is AttackBase {
  function execute(bytes32 source, bytes32) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _attack(source, direction, distance);
  }
}

contract AttackWithin1S is AttackBase {
  function execute(bytes32 source, bytes32) external {
    _attack(source, DirectionType.Forward, 1);
    _attack(source, DirectionType.Right, 1);
    _attack(source, DirectionType.Backward, 1);
    _attack(source, DirectionType.Left, 1);
  }
}

contract AttackForward1T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Forward, 1);
  }
}

contract AttackForward2T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Forward, 2);
  }
}

contract AttackForward4T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Forward, 4);
  }
}

contract AttackRight1T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Right, 1);
  }
}

contract AttackRight2T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Right, 2);
  }
}

contract AttackRight4T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Right, 4);
  }
}

contract AttackBackward1T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Backward, 1);
  }
}

contract AttackBackward2T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Backward, 2);
  }
}

contract AttackBackward4T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Backward, 4);
  }
}

contract AttackLeft1T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Left, 1);
  }
}

contract AttackLeft2T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Left, 2);
  }
}

contract AttackLeft4T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Left, 4);
  }
}

contract AttackRandomT is AttackBase {
  function execute(bytes32, bytes32 target) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _attack(target, direction, distance);
  }
}

contract AttackWithin1T is AttackBase {
  function execute(bytes32, bytes32 target) external {
    _attack(target, DirectionType.Forward, 1);
    _attack(target, DirectionType.Right, 1);
    _attack(target, DirectionType.Backward, 1);
    _attack(target, DirectionType.Left, 1);
  }
}
