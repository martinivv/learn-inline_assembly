// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract Types {
    function returnNumber() external pure returns (uint256 out_) {
        uint256 _returnValue = 0x16; /* or 22 */

        assembly {
            out_ := _returnValue
        }
    }

    function returnString() external pure returns (string memory out_) {
        bytes32 _stringInBytes = "";
        // The string should be <= 32 bytes.
        assembly {
            _stringInBytes := "Hey!"
        }
        out_ = string(abi.encode(_stringInBytes));
    }

    function returnTrue() external pure returns (bool out_) {
        assembly {
            out_ := 1
        }
    }
}
