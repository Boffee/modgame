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

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("AtPosition")));
bytes32 constant AtPositionTableId = _tableId;

library AtPosition {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32_ARRAY;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.INT128;
    _schema[1] = SchemaType.INT128;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](1);
    _fieldNames[0] = "value";
    return ("AtPosition", _fieldNames);
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
  function get(int128 x, int128 y) internal view returns (bytes32[] memory value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Get value (using the specified store) */
  function get(IStore _store, int128 x, int128 y) internal view returns (bytes32[] memory value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /** Set value */
  function set(int128 x, int128 y, bytes32[] memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    StoreSwitch.setField(_tableId, _keyTuple, 0, EncodeArray.encode((value)));
  }

  /** Set value (using the specified store) */
  function set(IStore _store, int128 x, int128 y, bytes32[] memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    _store.setField(_tableId, _keyTuple, 0, EncodeArray.encode((value)));
  }

  /** Get the length of value */
  function length(int128 x, int128 y) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    uint256 _byteLength = StoreSwitch.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 32;
  }

  /** Get the length of value (using the specified store) */
  function length(IStore _store, int128 x, int128 y) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    uint256 _byteLength = _store.getFieldLength(_tableId, _keyTuple, 0, getSchema());
    return _byteLength / 32;
  }

  /** Get an item of value (unchecked, returns invalid data if index overflows) */
  function getItem(int128 x, int128 y, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    bytes memory _blob = StoreSwitch.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Get an item of value (using the specified store) (unchecked, returns invalid data if index overflows) */
  function getItem(IStore _store, int128 x, int128 y, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    bytes memory _blob = _store.getFieldSlice(_tableId, _keyTuple, 0, getSchema(), _index * 32, (_index + 1) * 32);
    return (Bytes.slice32(_blob, 0));
  }

  /** Push an element to value */
  function push(int128 x, int128 y, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    StoreSwitch.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Push an element to value (using the specified store) */
  function push(IStore _store, int128 x, int128 y, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    _store.pushToField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /** Pop an element from value */
  function pop(int128 x, int128 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    StoreSwitch.popFromField(_tableId, _keyTuple, 0, 32);
  }

  /** Pop an element from value (using the specified store) */
  function pop(IStore _store, int128 x, int128 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    _store.popFromField(_tableId, _keyTuple, 0, 32);
  }

  /** Update an element of value at `_index` */
  function update(int128 x, int128 y, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    StoreSwitch.updateInField(_tableId, _keyTuple, 0, _index * 32, abi.encodePacked((_element)));
  }

  /** Update an element of value (using the specified store) at `_index` */
  function update(IStore _store, int128 x, int128 y, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    _store.updateInField(_tableId, _keyTuple, 0, _index * 32, abi.encodePacked((_element)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(bytes32[] memory value) internal view returns (bytes memory) {
    uint40[] memory _counters = new uint40[](1);
    _counters[0] = uint40(value.length * 32);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    return abi.encodePacked(_encodedLengths.unwrap(), EncodeArray.encode((value)));
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(int128 x, int128 y) internal pure returns (bytes32[] memory _keyTuple) {
    _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));
  }

  /* Delete all data for given keys */
  function deleteRecord(int128 x, int128 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, int128 x, int128 y) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint128((x))));
    _keyTuple[1] = bytes32(uint256(uint128((y))));

    _store.deleteRecord(_tableId, _keyTuple);
  }
}
