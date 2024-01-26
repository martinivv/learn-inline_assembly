// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

/* NOTE:
    These examples DO NOT require solution. Use them as a reference.
*/
contract VariableLength {
    struct Example {
        uint256 a;
        uint256 b;
        uint256 c;
    }

    function args(uint256 a, uint256[] calldata b, uint256 c) external {
        /* 
        The encoding (w/ parameters: 4, [1,2,3], 5) will be as follows:

        0x00 => 0x0...04
        0x20 => 0x0...60 -> pointer to the start of the array `b`. Solidity knows that this is a pointer, because of the function signature.
        0x40 => 0x0...05
        0x60 => 0x0...03 -> the length of the array
        0x80 => 0x0...01
        0xa0 => 0x0...02
        0xc0 => 0x0...03

        */
    }

    function argsStruct(uint256 a, Example calldata b, uint256 c) external {
        /* 
        The encoding (w/ parameters: 4, [1,2,3], 5) will be as follows:

        0x00 => 0x0...04
        0x20 => 0x0...01
        0x40 => 0x0...02
        0x60 => 0x0...03
        0x80 => 0x0...05

        */
    }

    // The same structure is kept when more or less arguments of these types are used.
}
