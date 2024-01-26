// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract StorageOne {
    uint256 x;

    uint128 A = 1;
    uint64 B = 2;
    uint32 C = 3;
    uint16 D = 4;
    uint8 E = 5;

    /* =================================================== X ================================================== */

    function setX(uint256 a_) external {
        assembly {
            sstore(x.slot, a_)
        }
    }

    function getX() external view returns (uint256 out_) {
        assembly {
            out_ := sload(x.slot)
        }
    }

    /* =================================================== D ================================================== */

    // The solution can be made using division, but shifting uses less gas, that's why I'll go with shifting.
    function getD() external view returns (uint256 out_) {
        assembly {
            let value := sload(D.slot)
            // value = 0x/00050004/00000003000000000000000200000000000000000000000000000001
            let shifted := shr(mul(D.offset, 8), value)
            // Each pair of 2 chars is 1 byte.
            // D.offset = 28, 28*2 chars to the right will get us to the value of our variable.
            // shifted = 0x/00000000000000000000000000000000000000000000000000000000/00050004

            // But we have to exclude the var that is to the left (the E).
            // This is a typical masking operation, f = 1111, ff = 1111 1111 => 8 bits or 1 byte;
            // and ffff => 2 bytes (removes the 1 left byte in the slot and the 1 byte from
            // the E variable)
            out_ := and(0xffff, shifted)
            // uint256(ret_) = 4
            // out_ = 0x00000000000000000000000000000000000000000000000000000000/0000/0004
        }
    }

    function setD() external {
        uint256 _newD = 10;

        assembly {
            // newD = 0x000000000000000000000000000000000000000000000000000000000000000a
            let s := sload(D.slot) // slot 0
            // s = 0x0005000400000003000000000000000200000000000000000000000000000001
            let clearedD := and(s, 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff)

            // mask     = 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // s        = 0x0005000400000003000000000000000200000000000000000000000000000001
            // About the mask:
            // V and 00 = 00,
            // V and FF = V,
            // V or 00 = V => that's why the `clearedD` is like this:
            // clearedD = 0x0005/0000/00000003000000000000000200000000000000000000000000000001
            let shiftedNewD := shl(mul(D.offset, 8), _newD)
            // shiftedNewE = 0x0000/000a/00000000000000000000000000000000000000000000000000000000
            let newVal := or(shiftedNewD, clearedD)
            // newVal      = 0x0005/000a/00000003000000000000000200000000000000000000000000000001
            sstore(D.slot, newVal)
        }
    }

    /* ================================================= REMIX ================================================ */

    function _getSlot(uint256 slot) external view returns (bytes32 out_) {
        assembly {
            out_ := sload(slot)
        }
    }

    function _getOffset() external pure returns (uint256 out_) {
        assembly {
            out_ := D.offset
        }
    }
}
