// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract UsingMemory {
    event SomeLog(uint256 indexed a, uint256 indexed b);
    event SomeLogV2(uint256 indexed a, bool);

    function return2and4() external pure returns (uint256, uint256) {
        assembly {
            mstore(0x00, 2)
            mstore(0x20, 4)
            return(0x00, 0x40)
        }
    }

    function requireCustomError() external view {
        assembly {
            if iszero(eq(caller(), 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D)) { revert(0, 0) }
        }
    }

    function hash() external pure returns (bytes32) {
        assembly {
            // Precaution to avoid collisions.
            let freeMemoryPointer := mload(0x40)

            // Stores 1,2,3 in memory.
            mstore(freeMemoryPointer, 1)
            mstore(add(freeMemoryPointer, 0x20), 2)
            mstore(add(freeMemoryPointer, 0x40), 3)

            // Updates the free memory pointer.
            mstore(0x40, add(freeMemoryPointer, 0x60)) // increase memory pointer by 96 bytes (0x60 in hex)

            // Stores in `0x00` (the scratch space) the hash. We specify — Beginning: `freeMemoryPointer`, Bytes Total: 0x60 (96 bytes).
            mstore(0x00, keccak256(freeMemoryPointer, 0x60))

            // Returns 32 bytes of data. We specify — Beginning: 0x00, End: 0x20.
            return(0x00, 0x20) // The return should be equal to the specified in the function declaration (`... returns (bytes32) {}`).
        }
    }

    function emitLog() external {
        assembly {
            // keccak256("SomeLog(uint256,uint256)")
            let signature := 0xc200138117cf199dd335a2c6079a6e1be01e6592b6a76d4b5fc31b169df819cc
            log3(0, 0, signature, 5, 6)
        }
    }

    function emitLogV2() external {
        assembly {
            // keccak256("SomeLogV2(uint256,bool)")
            let signature := 0x113cea0e4d6903d772af04edb841b17a164bff0f0d88609aedd1c4ac9b0c15c2
            mstore(0x00, 1)
            log2(0, 0x20, signature, 5)
        }
    }
}
