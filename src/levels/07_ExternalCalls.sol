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
        /*
        Call the function `get21`.

        "9a884bde": "get21()",
        */
    }

    function getViaRevert(address a_) external view returns (uint256) {
        /* 
        Call the `revertWith999()` and return `999`.

        "73712595": "revertWith999()"
        */
    }

    function callMultiply(address a_) external view returns (uint256 res) {
        /* 
        Call the `multiply()`.

        "196e6d84": "multiply(uint128,uint16)"
        */
    }

    function externalStateChangingCall(address _a) external {
        /* 
        Call the `setX(_x = 999)`, which makes a state change.

        "4018d9aa": "setX(uint256)"
        */
    }

    function unknownReturnSize(address _a, uint256 amount) external view returns (bytes memory) {
        /*
        Call the `variableReturnLength()` with amount = 10. The method returns unknown data size.

        "7c70b4db": "variableReturnLength(uint256)",
        */
    }

    constructor() payable {}

    function transferValue() external {
        address owner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38; // Foundry's default sender.

        /*
        Recreate in inline assembly.

        `(bool s,) = payable(owner).call{value: address(this).balance}("");
        require(s);`

        */
    }
}
