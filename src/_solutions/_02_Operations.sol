// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract Operations {
    function isPrime(uint256 x) external pure returns (bool out_) {
        assembly {
            out_ := 1

            let halfX := add(div(x, 2), 1)
            // The practice of skipping one of the three sections (of the for-loop), here also applies (can be applied).
            // lt => "less than"
            for { let i := 2 } lt(i, halfX) { i := add(i, 1) } {
                if iszero(mod(x, i)) {
                    out_ := 0
                    break
                }
            }
        }
    }

    // ============================

    function bitFlip() external pure returns (bytes32 out_) {
        // If the value is not zero (here is 2), simply is going to flip all of the bits and return non-zero value.
        // Which can cause some inaccuracies in our logic; it's recommended to mitigate from using `not`.
        // [You can see an explicit sample in the next function].
        assembly {
            out_ := not(2)
        }
    }

    function unsafe2NegationPart() external pure returns (uint256 out_) {
        out_ = 1;
        assembly {
            if not(2) { out_ := 2 }
        }
        // Returns 2.
    }

    // ============================

    // Check the table for further details: https://docs.soliditylang.org/en/latest/yul.html#yul
    function returnMax(uint256 a, uint256 b) external pure returns (uint256 out_) {
        assembly {
            if lt(a, b) { out_ := b }
            if iszero(lt(a, b)) { out_ := a }
        }
    }
}
