// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract Operations {
    function isPrime(uint256 x) external pure returns (bool out_) {
        // Write a for-loop that checks for prime numbers and returns `out_`.
    }

    function bitFlip() external pure returns (bytes32 out_) {
        /*
        This function DOES NOT require solution.

        What will happen here? And why this evaluation `not(2)` can result in falsy conditions in some cases?
        */
        assembly {
            out_ := not(2)
        }
    }

    function returnMax(uint256 a, uint256 b) external pure returns (uint256 out_) {
        // Return the max value out of 2 uint arguments. Requires using `if` statements, note
        // that Yul doesn't have an `else` statement.
    }
}
