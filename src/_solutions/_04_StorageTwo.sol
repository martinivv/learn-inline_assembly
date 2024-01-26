// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.23;

contract StorageTwo {
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
        uint256 _index = 2;

        assembly {
            out_ := sload(add(fixedArray.slot, _index))
        }
    }

    function getBigDynamicArrayValue() external view returns (uint256 out_) {
        uint256 _index = 0;

        // The length of the dynamic array is saved on the 3rd index.
        bytes32 location = keccak256(abi.encode(uint256(3)));
        assembly {
            out_ := sload(add(location, _index))
        }
    }

    function getSmallDynamicArrayValue() external view returns (uint256 out_) {
        bytes32 location = keccak256(abi.encode(uint256(4)));
        assembly {
            let s := sload(add(location, 0)) // `0` because they're packed in one slot
            let shifted := shr(mul(1, 8), s) // uint8 variables => 1 byte
            out_ := and(0xff, shifted)
        }
    }

    function getMappingValue() external view returns (uint256 out_) {
        uint256 _key = 1;

        bytes32 location = keccak256(abi.encode(_key, uint256(5)));
        assembly {
            out_ := sload(location)
        }
    }

    function getNestedMappingValue() external view returns (uint256 out_) {
        uint256 _key1 = 3;
        uint256 _key2 = 4;

        bytes32 location = keccak256(abi.encode(uint256(_key2), keccak256(abi.encode(uint256(_key1), uint256(6)))));
        assembly {
            out_ := sload(location)
        }
    }

    function getAddressToListValue() external view returns (uint256 out_) {
        address address_ = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

        bytes32 location = keccak256(abi.encode(keccak256(abi.encode(address_, uint256(7)))));
        assembly {
            out_ := sload(add(location, 0))
        }
    }
}
