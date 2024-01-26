// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {StorageTwo} from "../src/levels/04_StorageTwo.sol";

// import {StorageTwo} from "../src/_solutions/_04_StorageTwo.sol";

contract StorageTwoTest is Test {
    StorageTwo private level;

    function setUp() external {
        level = new StorageTwo();
    }

    function test_getFixedArrayValue() external {
        assertEq(level.getFixedArrayValue(), 30);
    }

    function test_getBigDynamicArrayValue() external {
        assertEq(level.getBigDynamicArrayValue(), 10);
    }

    function test_getSmallDynamicArrayValue() external {
        assertEq(level.getSmallDynamicArrayValue(), 2);
    }

    function test_getMappingValue() external {
        assertEq(level.getMappingValue(), 10);
    }

    function test_getNestedMappingValue() external {
        assertEq(level.getNestedMappingValue(), 30);
    }

    function test_getAddressToListValue() external {
        assertEq(level.getAddressToListValue(), 5000);
    }
}
