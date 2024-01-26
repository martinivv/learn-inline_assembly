// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

interface ICalldataDemo {
    function get2() external view returns (uint256);

    function get99(uint256) external view returns (uint256);
}

contract CallDemo {
    ICalldataDemo public target;

    constructor(ICalldataDemo _a) {
        target = _a;
    }

    function callGet2() external view returns (uint256) {
        return target.get2();
    }

    function callGet99(uint256 arg) external view returns (uint256) {
        return target.get99(arg);
    }
}

contract CalldataDemo {
    fallback() external {
        assembly {
            let cd := calldataload(0)
            // d2178b0800000000000000000000000000000000000000000000000000000000
            let selector := shr(0xe0, cd) // Shifts right 224 bits to get last 4 bytes.
            // 00000000000000000000000000000000000000000000000000000000d2178b08

            // Unlike other languages, `switch` statement does not "fall through".
            switch selector
            case 0xd2178b08 { /* `get2()` */ returnUint(2) }
            case 0xba88df04 { /* `get99(uint256)` */ returnUint(getNotSoSecretValue()) }
            default { revert(0, 0) }

            function getNotSoSecretValue() -> r {
                if lt(calldatasize(), 36) { revert(0, 0) }

                let arg1 := calldataload(4)
                if eq(arg1, 8) {
                    r := 88
                    leave
                }
                r := 99
            }

            function returnUint(v) {
                mstore(0, v)
                return(0, 0x20)
            }
        }
    }
}
