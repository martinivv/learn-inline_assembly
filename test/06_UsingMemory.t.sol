// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {UsingMemory} from "../src/levels/06_UsingMemory.sol";

// import {UsingMemory} from "../src/_solutions/_06_UsingMemory.sol";

contract UsingMemoryTest is Test {
    UsingMemory private level;

    event SomeLog(uint256 indexed a, uint256 indexed b);
    event SomeLogV2(uint256 indexed a, bool);

    function setUp() external {
        level = new UsingMemory();
    }

    function test_return2and4() external {
        (uint256 var1, uint256 var2) = level.return2and4();
        assertEq(abi.encode(var1, var2), abi.encode(2, 4));
    }

    function testFail_requireCustomError() external view {
        level.requireCustomError();
    }

    function test_hash() external {
        assertEq(level.hash(), keccak256(abi.encode(1, 2, 3)));
    }

    function test_emitLog() external {
        vm.expectEmit(true, true, false, false);
        emit SomeLog(5, 6);
        level.emitLog();
    }

    function test_emitLogV2() external {
        vm.expectEmit(true, false, false, true);
        emit SomeLogV2(5, true);
        level.emitLogV2();
    }
}
