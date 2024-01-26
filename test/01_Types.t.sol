// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {Types} from "../src/levels/01_Types.sol";

// import {Types} from "../src/_solutions/_01_Types.sol";

contract TypesTest is Test {
    Types private level;

    function setUp() external {
        level = new Types();
    }

    function test_returnNumber() external {
        assertEq(level.returnNumber(), 22);
    }

    function test_returnString() external {
        bytes32 myString = "Hey!";
        assertEq(level.returnString(), string(abi.encode(myString)));
    }

    function test_returnTrue() external {
        assertTrue(level.returnTrue());
    }
}
