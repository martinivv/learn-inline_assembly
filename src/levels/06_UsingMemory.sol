// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract UsingMemory {
    event SomeLog(uint256 indexed a, uint256 indexed b);
    event SomeLogV2(uint256 indexed a, bool);

    function return2and4() external pure returns (uint256, uint256) {
        // Return `2` and `4`, using inline assembly.
    }

    function requireCustomError() external view {
        /* 
        Simulate these behaviours:

        `require(msg.sender == 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);` AND
        `if (msg.sender != 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D) revert();`.

        */
    }

    function hash() external pure returns (bytes32) {
        /* 
        Execute the following:

        ` bytes memory toBeHashed = abi.encode(1, 2, 3);
        return keccak256(toBeHashed); `

        */
    }

    function emitLog() external {
        // Emit `SomeLog`.
    }

    function emitLogV2() external {
        // Emit `SomeLogV2`.
    }
}
