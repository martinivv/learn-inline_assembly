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
    // Build the `CalldataDemo` in Yul.

    // `get2()` => Should return `2`.
    // `get99()` => If the uint256 arg is `8` => return `88`, otherwise => `99`.

    fallback() external {
        /* ... */
    }
}
