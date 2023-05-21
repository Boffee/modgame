// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Predation")));
bytes32 constant PredationTableId = _tableId;

library Predation {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BOOL;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.BYTES32;
    _schema[1] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](1);
    _fieldNames[0] = "value";
    return ("Predation", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema() internal {
    StoreSwitch.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Register the table's schema (using the specified store) */
  function registerSchema(IStore _store) internal {
    _store.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Set the table's metadata */
  function setMetadata() internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Set the table's metadata (using the specified store) */
  function setMetadata(IStore _store) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    _store.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get value */
  function get(bytes32 predatorType, bytes32 preyType) internal view returns (bool value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Get value (using the specified store) */
  function get(IStore _store, bytes32 predatorType, bytes32 preyType) internal view returns (bool value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Set value */
  function set(bytes32 predatorType, bytes32 preyType, bool value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((value)));
  }

  /** Set value (using the specified store) */
  function set(IStore _store, bytes32 predatorType, bytes32 preyType, bool value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((value)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(bool value) internal view returns (bytes memory) {
    return abi.encodePacked(value);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 predatorType, bytes32 preyType) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 predatorType, bytes32 preyType) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 predatorType, bytes32 preyType) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32((predatorType));
    _keyTuple[1] = bytes32((preyType));

    _store.deleteRecord(_tableId, _keyTuple);
  }
}

function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}
