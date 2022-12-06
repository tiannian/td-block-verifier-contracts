// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Verifier {
    function verify_signature(
        bytes32 vote_hash,
        address validator,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (bool) {
        address val = ecrecover(vote_hash, v, r, s);

        return val == validator;
    }

    function compute_vote_hash(
        uint64 height,
        uint64 round,
        int64 second,
        int32 nanos,
        string calldata chainid,
        bytes32 block_hash,
        uint32 par_totol,
        bytes32 par_hash
    ) public pure returns (bytes32) {}
}
