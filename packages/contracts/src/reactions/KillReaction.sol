// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {BaseReaction} from "./BaseReaction.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";

abstract contract KillBase is BaseReaction {
  function _kill(bytes32 entity, DirectionType direction, int128 distance)
    internal
  {
    OrientationType orientation = _getNetOrientation(entity, direction);
    (int128 x, int128 y) = _getPosition(entity);
    bytes32[] memory entities;
    if (orientation == OrientationType.North) {
      entities = _getEntitiesAtPosition(x, y - distance);
    } else if (orientation == OrientationType.East) {
      entities = _getEntitiesAtPosition(x + distance, y);
    } else if (orientation == OrientationType.South) {
      entities = _getEntitiesAtPosition(x, y + distance);
    } else if (orientation == OrientationType.West) {
      entities = _getEntitiesAtPosition(x - distance, y);
    }

    for (uint256 i = 0; i < entities.length; i++) {
      _physics()._kill(entity, entities[i]);
    }
  }
}

contract KillS is KillBase {
  function execute(bytes32 source, bytes32 target) external {
    _physics()._kill(target, source);
  }
}

contract KillForward1S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 1);
  }
}

contract KillForward2S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 2);
  }
}

contract KillForward3S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 3);
  }
}

contract KillForward4S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 4);
  }
}

contract KillRight1S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 1);
  }
}

contract KillRight2S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 2);
  }
}

contract KillRight3S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 3);
  }
}

contract KillRight4S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 4);
  }
}

contract KillBackward1S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 1);
  }
}

contract KillBackward2S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 2);
  }
}

contract KillBackward3S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 3);
  }
}

contract KillBackward4S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 4);
  }
}

contract KillLeft1S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 1);
  }
}

contract KillLeft2S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 2);
  }
}

contract KillLeft3S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 3);
  }
}

contract KillLeft4S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 4);
  }
}

contract KillRandomS is KillBase {
  function execute(bytes32 source, bytes32) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _kill(source, direction, distance);
  }
}

contract KillWithin1S is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 1);
    _kill(source, DirectionType.Right, 1);
    _kill(source, DirectionType.Backward, 1);
    _kill(source, DirectionType.Left, 1);
  }
}

contract KillForward1T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Forward, 1);
  }
}

contract KillForward2T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Forward, 2);
  }
}

contract KillForward3T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Forward, 3);
  }
}

contract KillForward4T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Forward, 4);
  }
}

contract KillRight1T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Right, 1);
  }
}

contract KillRight2T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Right, 2);
  }
}

contract KillRight3T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Right, 3);
  }
}

contract KillRight4T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Right, 4);
  }
}

contract KillBackward1T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Backward, 1);
  }
}

contract KillBackward2T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Backward, 2);
  }
}

contract KillBackward3T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Backward, 3);
  }
}

contract KillBackward4T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Backward, 4);
  }
}

contract KillLeft1T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Left, 1);
  }
}

contract KillLeft2T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Left, 2);
  }
}

contract KillLeft3T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Left, 3);
  }
}

contract KillLeft4T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Left, 4);
  }
}

contract KillRandomT is KillBase {
  function execute(bytes32, bytes32 target) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _kill(target, direction, distance);
  }
}

contract KillWithin1T is KillBase {
  function execute(bytes32, bytes32 target) external {
    _kill(target, DirectionType.Forward, 1);
    _kill(target, DirectionType.Right, 1);
    _kill(target, DirectionType.Backward, 1);
    _kill(target, DirectionType.Left, 1);
  }
}
