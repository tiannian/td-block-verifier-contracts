// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract VerifierUtils {
    struct Timestamp {
        int64 second;
        int32 nanos;
    }

    function verify_signature(
        bytes32 commit_sig_hash,
        address validator,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (bool) {
        address val = ecrecover(commit_sig_hash, v, r, s);

        return val == validator;
    }

    struct BlockId {
        bytes32 block_hash;
        uint32 par_total;
        bytes32 par_hash;
    }

    struct CommitSig {
        uint64 height;
        uint64 round;
        Timestamp timestamp;
        string chain_id;
        BlockId block_id;
    }

    function decode_commit_sig(
        bytes calldata commit
    ) public pure returns (CommitSig memory) {}

    struct ConsensusVersion {
        uint64 blk;
        uint64 app;
    }

    struct BlockHeader {
        ConsensusVersion version;
        string chain_id;
        int64 height;
        Timestamp time;
        BlockId latest_block_id;
        bytes32 last_commit_hash;
        bytes32 data_hash;
        bytes32 validators_hash;
        bytes32 next_validators_hash;
        bytes32 consensus_hash;
        bytes32 app_hash;
        bytes32 last_results_hash;
        bytes32 evidence_hash;
        address proposer_address;
    }

    function compute_merkle_root(
        bytes[] calldata byteses
    ) public returns (bytes32) {}

    function compute_block_hash(
        BlockHeader memory header
    ) public returns (bytes32) {}

    struct Validator {
        bytes pub_key;
        int64 voting_power;
    }
}
