// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

/* NOTE:
    After you've learned the theory, use these examples to better understand the memory usage.
    These functions DO NOT require solution.
*/
contract Memory {
    struct Point {
        uint256 x;
        uint256 y;
    }

    event MemoryPointer(bytes32);
    event MemoryPointerMsize(bytes32, bytes32);

    function memPointer() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0x00...80
        Point memory p = Point({x: 1, y: 2});

        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0x00...c0
            // 0xc0 - 0x80 = 64,
            // or occupies exactly 64 bytes in memory (uint256 + uint256).
    }

    function memPointerV2() external {
        bytes32 x40;
        bytes32 _msize;
        assembly {
            x40 := mload(0x40)
            _msize := msize()
        }
        emit MemoryPointerMsize(x40, _msize); // 0x80, 0x60

        Point memory p = Point({x: 1, y: 2});
        assembly {
            x40 := mload(0x40)
            _msize := msize()
        }
        emit MemoryPointerMsize(x40, _msize); // 0xc0, 0xc0

        assembly {
            pop(mload(0xff))
            x40 := mload(0x40)
            _msize := msize()
        }
        emit MemoryPointerMsize(x40, _msize); // 0xc0, 0x120
    }

    function fixedArray() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0x80

        uint256[2] memory arr = [uint256(5), uint256(6)]; // Behaves the same way.
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0xc0
    }

    function abiEncode() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        abi.encode(uint256(5), uint256(19)); // Should process: the length, arg1, arg2, that's why 👇.
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0xe0
    }

    function abiEncode2() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        abi.encode(uint256(5), uint128(19)); // Each of the arguments will be padded to 32 bytes.
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0xe0
    }

    function abiEncodePacked() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        abi.encodePacked(uint256(5), uint128(19)); // Will not be padded.
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40); // 0xd0
    }

    event Debug(bytes32, bytes32, bytes32, bytes32);

    function args(uint256[] memory arr) external {
        bytes32 location;
        bytes32 len;
        bytes32 valueAtIndex0;
        bytes32 valueAtIndex1;
        assembly {
            location := arr // Like the heap in other languages. The location of the memory array.
            len := mload(arr) // Loading the bytes, corresponding to the length of the array.
            valueAtIndex0 := mload(add(arr, 0x20)) // Index 0.
            valueAtIndex1 := mload(add(arr, 0x40)) // Index 1.
                // ...
        }
        emit Debug(location, len, valueAtIndex0, valueAtIndex1);
    }

    function breakFreeMemoryPointer(uint256[1] memory foo) external pure returns (uint256) {
        assembly {
            mstore(0x40, 0x80)
        }
        uint256[1] memory bar = [uint256(6)]; // `bar[]` will override the `foo[]`.
        return foo[0];
    }

    uint8[] foo = [1, 2, 3, 4, 5, 6]; // In storage will be kept in a single storage slot.

    // If you load something from storage to memory, the sol compiler will NOT try to
    // pack them into a single slot.
    function unpacked() external view {
        uint8[] memory bar = foo; // Will be unpacked. Try it yourself in Remix.
    }
}
