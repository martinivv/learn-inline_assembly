// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {CalldataDemo, ICalldataDemo, CallDemo} from "../src/levels/09_CalldataDemo.sol";

// import {CalldataDemo, ICalldataDemo, CallDemo} from "../src/_solutions/_09_CalldataDemo.sol";

contract CalldataDemoTest is Test {
    CallDemo private level;

    function setUp() external {
        address toTestAddr = address(new CalldataDemo());
        level = new CallDemo(ICalldataDemo(toTestAddr));
    }

    function test_get2() external {
        assertEq(level.callGet2(), 2);
    }

    function test_get99() external {
        assertEq(level.callGet99(1), 99);
        assertEq(level.callGet99(8), 88);
    }
}
