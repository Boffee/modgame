// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {BaseReaction} from "./BaseReaction.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";

abstract contract MoveBase is BaseReaction {
  function _move(bytes32 entity, DirectionType direction, int128 distance)
    internal
  {
    OrientationType orientation = _getNetOrientation(entity, direction);
    if (orientation == OrientationType.North) {
      _physics()._moveRelative(entity, 0, distance);
    } else if (orientation == OrientationType.East) {
      _physics()._moveRelative(entity, distance, 0);
    } else if (orientation == OrientationType.South) {
      _physics()._moveRelative(entity, 0, -distance);
    } else if (orientation == OrientationType.West) {
      _physics()._moveRelative(entity, -distance, 0);
    }
  }
}

contract MoveForward1S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Forward, 1);
  }
}

contract MoveForward2S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Forward, 2);
  }
}

contract MoveForward4S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Forward, 4);
  }
}

contract MoveRight1S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Right, 1);
  }
}

contract MoveRight2S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Right, 2);
  }
}

contract MoveRight4S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Right, 4);
  }
}

contract MoveBackward1S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Backward, 1);
  }
}

contract MoveBackward2S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Backward, 2);
  }
}

contract MoveBackward4S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Backward, 4);
  }
}

contract MoveLeft1S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Left, 1);
  }
}

contract MoveLeft2S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Left, 2);
  }
}

contract MoveLeft4S is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Left, 4);
  }
}

contract MoveRandomS is MoveBase {
  function execute(bytes32 source, bytes32) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _move(source, direction, distance);
  }
}

contract MoveForward1T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Forward, 1);
  }
}

contract MoveForward2T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Forward, 2);
  }
}

contract MoveForward4T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Forward, 4);
  }
}

contract MoveRight1T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Right, 1);
  }
}

contract MoveRight2T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Right, 2);
  }
}

contract MoveRight4T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Right, 4);
  }
}

contract MoveBackward1T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Backward, 1);
  }
}

contract MoveBackward2T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Backward, 2);
  }
}

contract MoveBackward4T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Backward, 4);
  }
}

contract MoveLeft1T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Left, 1);
  }
}

contract MoveLeft2T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Left, 2);
  }
}

contract MoveLeft4T is MoveBase {
  function execute(bytes32, bytes32 target) external {
    _move(target, DirectionType.Left, 4);
  }
}

contract MoveRandomT is MoveBase {
  function execute(bytes32, bytes32 target) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _move(target, direction, distance);
  }
}
