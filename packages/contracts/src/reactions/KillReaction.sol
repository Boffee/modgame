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
      entities = _getEntitiesAtPosition(x, y + distance);
    } else if (orientation == OrientationType.East) {
      entities = _getEntitiesAtPosition(x + distance, y);
    } else if (orientation == OrientationType.South) {
      entities = _getEntitiesAtPosition(x, y - distance);
    } else if (orientation == OrientationType.West) {
      entities = _getEntitiesAtPosition(x - distance, y);
    }

    for (uint256 i = 0; i < entities.length; i++) {
      _physics()._kill(entity, entities[i]);
    }
  }
}

contract KillForward1 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 1);
  }
}

contract KillForward2 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 2);
  }
}

contract KillForward4 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Forward, 4);
  }
}

contract KillRight1 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 1);
  }
}

contract KillRight2 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 2);
  }
}

contract KillRight4 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Right, 4);
  }
}

contract KillBackward1 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 1);
  }
}

contract KillBackward2 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 2);
  }
}

contract KillBackward4 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Backward, 4);
  }
}

contract KillLeft1 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 1);
  }
}

contract KillLeft2 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 2);
  }
}

contract KillLeft4 is KillBase {
  function execute(bytes32 source, bytes32) external {
    _kill(source, DirectionType.Left, 4);
  }
}
