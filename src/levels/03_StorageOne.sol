// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

/* NOTE:
    Feel free to test in Remix. 
    https://docs.soliditylang.org/en/latest/yul.html#yul
*/
contract StorageOne {
    uint256 x;

    uint128 A = 1;
    uint64 B = 2;
    uint32 C = 3;
    uint16 D = 4;
    uint8 E = 5;

    /* =================================================== X ================================================== */

    function setX(uint256 a_) external {
        // Write a setter function for `x`.
    }

    function getX() external view returns (uint256 out_) {
        // Write a getter function for `x`.
    }

    /* =================================================== D ================================================== */

    function getD() external view returns (uint256 out_) {
        // Write a getter function for `D`, shared in slot 1.
    }

    function setD() external {
        uint256 _newD = 10;
        // Write a setter function for `D`, set it to `_newD`.
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
