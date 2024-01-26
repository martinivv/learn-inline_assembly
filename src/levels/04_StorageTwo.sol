// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract StorageTwo {
    /* 
    Before you start, answer:
    1. How the fixed array is stored in contract's storage?
    2. How the dynamic array is stored?
    3. How the mapping is stored?
    */

    uint256[3] fixedArray;
    uint256[] bigDynamicArray;
    uint8[] smallDynamicArray;

    mapping(uint256 => uint256) public myMapping;
    mapping(uint256 => mapping(uint256 => uint256)) public nestedMapping;
    mapping(address => uint256[]) public addressToList;

    constructor() {
        fixedArray = [10, 20, 30];
        bigDynamicArray = [10, 20, 30];
        smallDynamicArray = [1, 2, 3];

        myMapping[1] = 10;
        myMapping[2] = 20;
        nestedMapping[3][4] = 30;
        addressToList[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = [5000, 1337];
    }

    function getFixedArrayValue() external view returns (uint256 out_) {
        // Get the element on `_index` in `fixedArray`.
        uint256 _index = 2;
    }

    function getBigDynamicArrayValue() external view returns (uint256 out_) {
        // Get the element on `_index` in `bigDynamicArray`.
        uint256 _index = 0;
    }

    function getSmallDynamicArrayValue() external view returns (uint256 out_) {
        // Get the element on the 1st index in `smallDynamicArray`.
    }

    function getMappingValue() external view returns (uint256 out_) {
        // Get the uint256 value of `_key`.
        uint256 _key = 1;
    }

    function getNestedMappingValue() external view returns (uint256 out_) {
        // Get the uint256 value using the keys.
        uint256 _key1 = 3;
        uint256 _key2 = 4;
    }

    function getAddressToListValue() external view returns (uint256 out_) {
        // Get the 0 index out of the mapping's list.
        address address_ = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    }
}
