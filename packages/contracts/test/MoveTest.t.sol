// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/console2.sol";
import "forge-std/Test.sol";
import {MudV2Test} from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";
import {getKeysWithValue} from
  "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";
import {IWorld} from "../src/codegen/world/IWorld.sol";
import "../src/codegen/Tables.sol";
import "../src/constants.sol";

contract MoveTest is MudV2Test {
  IWorld public world;

  function setUp() public override {
    super.setUp();
    world = IWorld(worldAddress);
  }

  function testDebugMove() public {
    vm.prank(worldAddress);
    world._move("hello", 2, 9);
    vm.prank(worldAddress);
    world._move("hello", 2, 7);
  }
}
