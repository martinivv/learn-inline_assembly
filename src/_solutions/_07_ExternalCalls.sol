// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract PointTo {
    // "0c55699c": "x()"
    uint256 public x;

    function get21() external pure returns (uint256) {
        return 21;
    }

    function revertWith999() external pure returns (uint256) {
        assembly {
            mstore(0x00, 999)
            revert(0x00, 0x20)
        }
    }

    function multiply(uint128 _x, uint16 _y) external pure returns (uint256) {
        return _x * _y;
    }

    function setX(uint256 _x) external {
        x = _x;
    }

    function variableReturnLength(uint256 len) external pure returns (bytes memory) {
        bytes memory ret = new bytes(len);
        for (uint256 i = 0; i < ret.length; i++) {
            ret[i] = 0xab;
        }
        return ret;
    }
}

contract ExternalCalls {
    function callViewNoArgs(address a_) external view returns (uint256) {
        // "9a884bde": "get21()",

        assembly {
            mstore(0x00, 0x9a884bde)
            // 000000000000000000000000000000000000000000000000000000009a884bde
            //                                                         |       |
            //                                                         28      32
            let success := staticcall(gas(), a_, 28, 32, 0x00, 0x20)
            // gas() => all the remaining gas;
            // 28-32 => `tx.data` we're pointing to (the func selector);
            // 0x00-0x20 => the region in memory we're saving the result back.
            if iszero(success) { revert(0, 0) }
            return(0x00, 0x20) // How does the `return` statement work in Yul? Start to End.
        }
    }

    function getViaRevert(address a_) external view returns (uint256) {
        // "73712595": "revertWith999()",

        assembly {
            mstore(0x00, 0x73712595)
            // 👇 will be 0 (false), but we won't check it.
            pop(staticcall(gas(), a_, 28, 32, 0x00, 0x20))
            // So the return will be `999`, although the function `revertWith999` reverted.
            return(0x00, 0x20)
        }
    }

    function callMultiply(address a_) external view returns (uint256 res) {
        // "196e6d84": "multiply(uint128,uint16)"

        assembly {
            let mptr := mload(0x40)
            let oldMptr := mptr
            mstore(mptr, 0x196e6d84)
            mstore(add(mptr, 0x20), 3)
            mstore(add(mptr, 0x40), 11)
            mstore(0x40, add(mptr, 0x60)) // Advance the memory pointer 3 x 32 bytes.
            // 00000000000000000000000000000000000000000000000000000000196e6d84
            // 0000000000000000000000000000000000000000000000000000000000000003
            // 000000000000000000000000000000000000000000000000000000000000000b
            let success := staticcall(gas(), a_, add(oldMptr, 28), mload(0x40), 0x00, 0x20)
            if iszero(success) { revert(0, 0) }

            res := mload(0x00)
        }
    }

    function externalStateChangingCall(address _a) external {
        // "4018d9aa": "setX(uint256)"
        assembly {
            mstore(0x00, 0x4018d9aa)
            mstore(0x20, 999)
            // memory now looks like this
            //0x000000000000000000000000000000000000000000000000000000004018d9aa...
            //  0000000000000000000000000000000000000000000000000000000000000009
            let success := call(gas(), _a, callvalue(), 28, add(28, 32), 0x00, 0x00) // `callvalue()` will equal to `0`.
            if iszero(success) { revert(0, 0) }
        }
    }

    function unknownReturnSize(address _a, uint256 amount) external view returns (bytes memory) {
        // "7c70b4db": "variableReturnLength(uint256)",

        assembly {
            mstore(0x00, 0x7c70b4db)
            mstore(0x20, amount)

            let success := staticcall(gas(), _a, 28, add(28, 32), 0x00, 0x00)
            if iszero(success) { revert(0, 0) }

            returndatacopy(0, 0, returndatasize()) // Into my memory slot 0, copy the return data from 0 with the total size.
            return(0, returndatasize())
        }
    }

    constructor() payable {}

    function transferValue() external {
        address owner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38; // Foundry's default sender.

        assembly {
            let s := call(gas(), owner, selfbalance(), 0, 0, 0, 0) // First 0,0 pair correspond to the send data, second pair — how is handled.
            if iszero(s) { revert(0, 0) }
        }
    }
}
