// SPDX-License-Identifier: Apache-2.0


// An example of a simple 100 % Yul.


object "Simple" {
    // 👇 is the constructor, init/creation portion of the bytecode.
    code {
        // At 0th slot copy the start of the `runtime` portion with it's size (copy all of it).
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        // Return from the 0th slot to the size of the `runtime`.
        return(0, datasize("runtime"))        
    }

    // Runtime part of the bytecode.
    object "runtime" {
        
        code {
            // We do not have function selectors, "that is a Solidity thing".
            mstore(0x00, 2)
            return(0x00, 0x20)
        }
    }
}