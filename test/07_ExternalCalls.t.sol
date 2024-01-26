// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {PointTo, ExternalCalls} from "../src/levels/07_ExternalCalls.sol";

// import {PointTo, ExternalCalls} from "../src/_solutions/_07_ExternalCalls.sol";

contract ExternalCallsTest is Test {
    ExternalCalls private level;

    address private pointToAddr;

    function setUp() external {
        pointToAddr = address(new PointTo());
        level = new ExternalCalls{value: 1 ether}();
    }

    function test_callViewNoArgs() external {
        assertEq(level.callViewNoArgs(pointToAddr), 21);
    }

    function test_getViaRevert() external {
        assertEq(level.getViaRevert(pointToAddr), 999);
    }

    function test_callMultiply() external {
        assertEq(level.callMultiply(pointToAddr), 33);
    }

    function test_externalStateChangingCall() external {
        level.externalStateChangingCall(pointToAddr);
        assertEq(PointTo(pointToAddr).x(), 999);
    }

    function test_unknownReturnSize() external {
        assertEq(level.unknownReturnSize(pointToAddr, 10).length, 10);
    }

    function test_transferValue() external {
        level.transferValue();
        assertEq(address(level).balance, 0);
    }
}
