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

contract TriggerForward1 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 1);
  }
}

contract TriggerForward2 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 2);
  }
}

contract TriggerForward4 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Forward, 4);
  }
}

contract TriggerRight1 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Right, 1);
  }
}

contract TriggerRight2 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Right, 2);
  }
}

contract TriggerRight4 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Right, 4);
  }
}

contract TriggerBackward1 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Backward, 1);
  }
}

contract TriggerBackward2 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Backward, 2);
  }
}

contract TriggerBackward4 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Backward, 4);
  }
}

contract TriggerLeft1 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Left, 1);
  }
}

contract TriggerLeft2 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Left, 2);
  }
}

contract TriggerLeft4 is TriggerBase {
  function execute(bytes32 source, bytes32) external {
    _trigger(source, DirectionType.Left, 4);
  }
}
