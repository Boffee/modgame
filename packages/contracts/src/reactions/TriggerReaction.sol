// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {BaseReaction} from "./BaseReaction.sol";
import {OrientationType, DirectionType} from "../codegen/Types.sol";

abstract contract TriggerBase is BaseReaction {
  function _trigger(bytes32 entity, DirectionType direction, int128 distance)
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
      _physics()._trigger(entity, entities[i]);
    }
  }
}

contract TriggerForward1S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 1);
  }
}

contract TriggerForward2S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 2);
  }
}

contract TriggerForward4S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 4);
  }
}

contract TriggerRight1S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Right, 1);
  }
}

contract TriggerRight2S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Right, 2);
  }
}

contract TriggerRight4S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Right, 4);
  }
}

contract TriggerBackward1S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Backward, 1);
  }
}

contract TriggerBackward2S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Backward, 2);
  }
}

contract TriggerBackward4S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Backward, 4);
  }
}

contract TriggerLeft1S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Left, 1);
  }
}

contract TriggerLeft2S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Left, 2);
  }
}

contract TriggerLeft4S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Left, 4);
  }
}

contract TriggerRandomS is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _trigger(source, direction, distance);
  }
}

contract TriggerWithin1S is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 1);
    _trigger(source, DirectionType.Right, 1);
    _trigger(source, DirectionType.Backward, 1);
    _trigger(source, DirectionType.Left, 1);
  }
}

contract TriggerForward1T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Forward, 1);
  }
}

contract TriggerForward2T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Forward, 2);
  }
}

contract TriggerForward4T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Forward, 4);
  }
}

contract TriggerRight1T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Right, 1);
  }
}

contract TriggerRight2T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Right, 2);
  }
}

contract TriggerRight4T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Right, 4);
  }
}

contract TriggerBackward1T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Backward, 1);
  }
}

contract TriggerBackward2T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Backward, 2);
  }
}

contract TriggerBackward4T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Backward, 4);
  }
}

contract TriggerLeft1T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Left, 1);
  }
}

contract TriggerLeft2T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Left, 2);
  }
}

contract TriggerLeft4T is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    _trigger(target, DirectionType.Left, 4);
  }
}

contract TriggerRandomT is TriggerBase {
  function execute(bytes32, bytes32 target) external {
    uint128 random =
      uint128(uint256(keccak256(abi.encodePacked(block.timestamp))));
    DirectionType direction = DirectionType(random % 4);
    random = uint128(uint256(keccak256(abi.encodePacked(random))));
    int128 distance = int128(1 + (random % 4));
    _trigger(target, direction, distance);
  }
}

contract TriggerWithin1T is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 1);
    _trigger(source, DirectionType.Right, 1);
    _trigger(source, DirectionType.Backward, 1);
    _trigger(source, DirectionType.Left, 1);
  }
}
