// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {StorageOne} from "../src/levels/03_StorageOne.sol";

// import {StorageOne} from "../src/_solutions/_03_StorageOne.sol";

contract StorageOneTest is Test {
    StorageOne private level;

    function setUp() external {
        level = new StorageOne();
    }

    function test_SetNGetX() external {
        level.setX(1);
        assertEq(level.getX(), 1);
    }

    function test_getD() external {
        assertEq(level.getD(), 4);
    }

    function test_setD() external {
        level.setD();
        assertEq(level.getD(), 10);
    }
}
