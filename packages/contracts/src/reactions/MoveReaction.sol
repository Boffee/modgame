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

contract MoveForward1 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Forward, 1);
  }
}

contract MoveForward2 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Forward, 2);
  }
}

contract MoveForward4 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Forward, 4);
  }
}

contract MoveRight1 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Right, 1);
  }
}

contract MoveRight2 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Right, 2);
  }
}

contract MoveRight4 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Right, 4);
  }
}

contract MoveBackward1 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Backward, 1);
  }
}

contract MoveBackward2 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Backward, 2);
  }
}

contract MoveBackward4 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Backward, 4);
  }
}

contract MoveLeft1 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Left, 1);
  }
}

contract MoveLeft2 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Left, 2);
  }
}

contract MoveLeft4 is MoveBase {
  function execute(bytes32 source, bytes32) external {
    _move(source, DirectionType.Left, 4);
  }
}

contract MoveRandom is MoveBase {
  function execute(bytes32 source, bytes32) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    // kinda random
    int128 distance = int128(1 + (random % 4));
    _move(source, direction, distance);
  }
}
