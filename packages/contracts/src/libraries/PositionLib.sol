// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {SignedMath} from "@openzeppelin/contracts/utils/math/SignedMath.sol";
import {Position, PositionData} from "../codegen/tables/Position.sol";
import {getKeysWithValue} from
  "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";
import {
  Position,
  PositionData,
  PositionTableId
} from "../codegen/tables/Position.sol";

library PositionLib {
  using PositionExtension for PositionData;

  function getEntitiesAtPosition(int128 x, int128 y)
    internal
    view
    returns (bytes32[] memory)
  {
    return getKeysWithValue(PositionTableId, Position.encode(x, y));
  }

  /**
   * @dev Checks if two positions are collocated
   * @param _entity1 first entity
   * @param _entity2 second entity
   * @return true if the two positions are collocated, false otherwise
   */
  function collocated(bytes32 _entity1, bytes32 _entity2)
    internal
    view
    returns (bool)
  {
    return Position.get(_entity1).collocated(Position.get(_entity2));
  }

  /**
   * @dev Checks if a position is collocated with another position
   * @param _entity first entity
   * @param _x x coordinate of the second position
   * @param _y y coordinate of the second position
   * @return true if the two positions are collocated, false otherwise
   */
  function collocated(bytes32 _entity, int128 _x, int128 _y)
    internal
    view
    returns (bool)
  {
    return Position.get(_entity).collocated(_x, _y);
  }

  /**
   * @dev Checks if two positions are within a certain distance of each other
   * @param _entity1 first entity
   * @param _entity2 second entity
   * @param _distance maximum distance between the two positions
   * @return true if the two positions are within the specified distance of each
   * other, false otherwise
   */
  function withinDistance(bytes32 _entity1, bytes32 _entity2, uint256 _distance)
    internal
    view
    returns (bool)
  {
    return
      Position.get(_entity1).withinDistance(Position.get(_entity2), _distance);
  }

  /**
   * @dev Checks if a position is within a certain distance of a coordinate
   * @param _entity first entity
   * @param _x x coordinate of the second position
   * @param _y y coordinate of the second position
   * @param _distance maximum distance between the two positions
   * @return true if the two positions are within the specified distance of each
   * other, false otherwise
   */
  function withinDistance(
    bytes32 _entity,
    int128 _x,
    int128 _y,
    uint256 _distance
  ) internal view returns (bool) {
    return Position.get(_entity).withinDistance(_x, _y, _distance);
  }

  /**
   * @dev Calculates the distance between two positions
   * @param _entity1 first entity
   * @param _entity2 second entity
   * @return distance between the two positions
   */
  function distance(bytes32 _entity1, bytes32 _entity2)
    internal
    view
    returns (uint256)
  {
    return Position.get(_entity1).distance(Position.get(_entity2));
  }

  /**
   * @dev Calculates the distance between a position and a coordinate
   * @param _entity first entity
   * @param _x x coordinate of the second position
   * @param _y y coordinate of the second position
   * @return distance between the two positions
   */
  function distance(bytes32 _entity, int128 _x, int128 _y)
    internal
    view
    returns (uint256)
  {
    return Position.get(_entity).distance(_x, _y);
  }
}

library PositionExtension {
  using SignedMath for int128;

  /**
   * @dev Checks if two positions are collocated
   * @param self first position
   * @param other second position
   * @return true if the two positions are collocated, false otherwise
   */
  function collocated(PositionData memory self, PositionData memory other)
    internal
    pure
    returns (bool)
  {
    return collocated(self, other.x, other.y);
  }

  /**
   * @dev Checks if a position is collocated with another position
   * @param self first position
   * @param x x coordinate of the second position
   * @param y y coordinate of the second position
   * @return true if the two positions are collocated, false otherwise
   */
  function collocated(PositionData memory self, int128 x, int128 y)
    internal
    pure
    returns (bool)
  {
    return self.x == x && self.y == y;
  }

  /**
   * @dev Checks if two positions are within a certain distance of each other
   * @param self first position
   * @param other second position
   * @param _distance maximum distance between the two positions
   * @return true if the two positions are within the specified distance of each
   * other, false otherwise
   */
  function withinDistance(
    PositionData memory self,
    PositionData memory other,
    uint256 _distance
  ) internal pure returns (bool) {
    return withinDistance(self, other.x, other.y, _distance);
  }

  /**
   * @dev Checks if a position is within a certain distance of a coordinate
   * @param self first position
   * @param x x coordinate of the second position
   * @param y y coordinate of the second position
   * @param _distance maximum distance between the two positions
   * @return true if the two positions are within the specified distance of each
   * other, false otherwise
   */
  function withinDistance(
    PositionData memory self,
    int128 x,
    int128 y,
    uint256 _distance
  ) internal pure returns (bool) {
    return (self.x - x).abs() + (self.y - y).abs() <= _distance;
  }

  /**
   * @dev Calculates the distance between two positions
   * @param self first position
   * @param other second position
   * @return distance between the two positions
   */
  function distance(PositionData memory self, PositionData memory other)
    internal
    pure
    returns (uint256)
  {
    return distance(self, other.x, other.y);
  }

  /**
   * @dev Calculates the distance between a position and a coordinate
   * @param self first position
   * @param x x coordinate of the second position
   * @param y y coordinate of the second position
   * @return distance between the two positions
   */
  function distance(PositionData memory self, int128 x, int128 y)
    internal
    pure
    returns (uint256)
  {
    return (self.x - x).abs() + (self.y - y).abs();
  }

  function entities(PositionData memory self)
    internal
    view
    returns (bytes32[] memory)
  {
    return getKeysWithValue(PositionTableId, Position.encode(self.x, self.y));
  }
}
