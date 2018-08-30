pragma solidity ^0.4.24;

// String Utils v0.1

/// @title String Utils - String utility functions
/// @author Piper Merriam - <pipermerriam@gmail.com>
library StringLib {
    /// @dev Converts an unsigned integert to its string representation.
    /// @param v The number to be converted.
    function uintToBytes(uint v) public pure returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        }
        else {
            while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }

    /// @dev Converts a numeric string to it's unsigned integer representation.
    /// @param v The string to be converted.
    function bytesToUInt(bytes32 v) public pure returns (uint ret) {

        if (v == 0x0) {
            revert();
        }

        uint digit;

        for (uint i = 0; i < 32; i++) {
            digit = uint((uint(v) / (2 ** (8 * (31 - i)))) & 0xff);
            if (digit == 0) {
                break;
            }
            else if (digit < 48 || digit > 57) {
                revert();
            }
            ret *= 10;
            ret += (digit - 48);
        }
        return ret;
    }

    function stringToBytes32(string memory _src) public pure returns (bytes32 result) {

      bytes memory tempEmptyStringTest = bytes(_src);

      if (tempEmptyStringTest.length == 0) {
        return 0x0;
      }

      assembly {
        result := mload(add(_src, 32))
      }
    }
}


/// @title String Utils - String utility functions
/// @author Piper Merriam - <pipermerriam@gmail.com>
library StringUtils {
    /// @dev Converts an unsigned integert to its string representation.
    /// @param v The number to be converted.
    function uintToBytes(uint v) public pure returns (bytes32 ret) {
      return StringLib.uintToBytes(v);
    }

    /// @dev Converts a numeric string to it's unsigned integer representation.
    /// @param v The string to be converted.
    function bytesToUInt(bytes32 v) public pure returns (uint ret) {
      return StringLib.bytesToUInt(v);
    }

    function stringToBytes32(string memory _src)  public pure returns (bytes32) {
      return StringLib.stringToBytes32(_src);
    }
}
