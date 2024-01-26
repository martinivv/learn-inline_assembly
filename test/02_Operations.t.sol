// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {Operations} from "../src/levels/02_Operations.sol";

// import {Operations} from "../src/_solutions/_02_Operations.sol";

contract OperationsTest is Test {
    Operations private level;

    function setUp() external {
        level = new Operations();
    }

    function test_isPrime() external {
        assertEq(level.isPrime(3), true);
        assertEq(level.isPrime(7), true);
        assertEq(level.isPrime(10), false);
        assertEq(level.isPrime(22), false);
    }

    function test_returnMax() external {
        assertEq(level.returnMax(2, 10), 10);
        assertEq(level.returnMax(123, 531), 531);
        assertEq(level.returnMax(10, 2), 10);
        assertEq(level.returnMax(743, 241), 743);
    }
}
