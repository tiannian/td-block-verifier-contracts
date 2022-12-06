// File automatically generated by protoc-gen-sol v0.2.0
// SPDX-License-Identifier: CC0
pragma solidity ^0.8.9;
pragma experimental ABIEncoderV2;

import "@lazyledger/protobuf3-solidity-lib/contracts/ProtobufLib.sol";

enum SignedMsgType {
    SIGNED_MSG_TYPE_UNKNOWN,
    SIGNED_MSG_TYPE_PREVOTE,
    SIGNED_MSG_TYPE_PRECOMMIT
}

struct Timestamp {
    int64 second;
    int32 nanos;
}

library TimestampCodec {
    function decode(
        uint64 initial_pos,
        bytes memory buf,
        uint64 len
    ) internal pure returns (bool, uint64, Timestamp memory) {
        // Message instance
        Timestamp memory instance;
        // Previous field number
        uint64 previous_field_number = 0;
        // Current position in the buffer
        uint64 pos = initial_pos;

        // Sanity checks
        if (pos + len < pos) {
            return (false, pos, instance);
        }

        while (pos - initial_pos < len) {
            // Decode the key (field number and wire type)
            bool success;
            uint64 field_number;
            ProtobufLib.WireType wire_type;
            (success, pos, field_number, wire_type) = ProtobufLib.decode_key(
                pos,
                buf
            );
            if (!success) {
                return (false, pos, instance);
            }

            // Check that the field number is within bounds
            if (field_number > 2) {
                return (false, pos, instance);
            }

            // Check that the field number of monotonically increasing
            if (field_number <= previous_field_number) {
                return (false, pos, instance);
            }

            // Check that the wire type is correct
            success = check_key(field_number, wire_type);
            if (!success) {
                return (false, pos, instance);
            }

            // Actually decode the field
            (success, pos) = decode_field(pos, buf, field_number, instance);
            if (!success) {
                return (false, pos, instance);
            }

            previous_field_number = field_number;
        }

        // Decoding must have consumed len bytes
        if (pos != initial_pos + len) {
            return (false, pos, instance);
        }

        return (true, pos, instance);
    }

    function check_key(
        uint64 field_number,
        ProtobufLib.WireType wire_type
    ) internal pure returns (bool) {
        if (field_number == 1) {
            return wire_type == ProtobufLib.WireType.Varint;
        }

        if (field_number == 2) {
            return wire_type == ProtobufLib.WireType.Varint;
        }

        return false;
    }

    function decode_field(
        uint64 initial_pos,
        bytes memory buf,
        uint64 field_number,
        Timestamp memory instance
    ) internal pure returns (bool, uint64) {
        uint64 pos = initial_pos;

        if (field_number == 1) {
            bool success;
            (success, pos) = decode_1(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 2) {
            bool success;
            (success, pos) = decode_2(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        return (false, pos);
    }

    // Timestamp.second
    function decode_1(
        uint64 pos,
        bytes memory buf,
        Timestamp memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        int64 v;
        (success, pos, v) = ProtobufLib.decode_int64(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (v == 0) {
            return (false, pos);
        }

        instance.second = v;

        return (true, pos);
    }

    // Timestamp.nanos
    function decode_2(
        uint64 pos,
        bytes memory buf,
        Timestamp memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        int32 v;
        (success, pos, v) = ProtobufLib.decode_int32(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (v == 0) {
            return (false, pos);
        }

        instance.nanos = v;

        return (true, pos);
    }

    // Holds encoded version of message
    struct Timestamp__Encoded {
        bytes second__Key;
        bytes second;
        bytes nanos__Key;
        bytes nanos;
    }

    // Holds encoded version of nested message
    struct Timestamp__Encoded__Nested {
        bytes key;
        bytes length;
        bytes nestedInstance;
    }

    function encode(
        Timestamp memory instance
    ) internal pure returns (bytes memory) {
        Timestamp__Encoded memory encodedInstance;
        uint64 len;
        uint64 index;

        // Omit encoding second if default value
        if (uint64(instance.second) != 0) {
            // Encode key for second
            encodedInstance.second__Key = ProtobufLib.encode_key(
                1,
                uint64(ProtobufLib.WireType.Varint)
            );
            // Encode second
            encodedInstance.second = ProtobufLib.encode_int64(instance.second);
        }

        // Omit encoding nanos if default value
        if (instance.nanos != 0) {
            // Encode key for nanos
            encodedInstance.nanos__Key = ProtobufLib.encode_key(
                2,
                uint64(ProtobufLib.WireType.Varint)
            );
            // Encode nanos
            encodedInstance.nanos = ProtobufLib.encode_int32(instance.nanos);
        }

        bytes memory finalEncoded;
        index = 0;
        len = 0;
        len += uint64(encodedInstance.second.length);
        len += uint64(encodedInstance.nanos.length);
        finalEncoded = new bytes(len);

        uint64 j;
        j = 0;
        while (j < encodedInstance.second.length) {
            finalEncoded[index++] = encodedInstance.second[j];
        }
        j = 0;
        while (j < encodedInstance.nanos.length) {
            finalEncoded[index++] = encodedInstance.nanos[j];
        }

        return finalEncoded;
    }

    // Encode a nested Timestamp, wrapped in key and length if non-default
    function encodeNested(
        uint64 field_number,
        Timestamp memory instance
    ) internal pure returns (Timestamp__Encoded__Nested memory) {
        Timestamp__Encoded__Nested memory wrapped;

        wrapped.nestedInstance = encode(instance);

        uint64 len = uint64(wrapped.nestedInstance.length);
        if (len > 0) {
            wrapped.key = ProtobufLib.encode_key(field_number, 2);
            wrapped.length = ProtobufLib.encode_uint64(len);
        }

        return wrapped;
    }
}

struct CanonicalBlockID {
    bytes hash;
    CanonicalPartSetHeader part_set_header;
}

library CanonicalBlockIDCodec {
    function decode(
        uint64 initial_pos,
        bytes memory buf,
        uint64 len
    ) internal pure returns (bool, uint64, CanonicalBlockID memory) {
        // Message instance
        CanonicalBlockID memory instance;
        // Previous field number
        uint64 previous_field_number = 0;
        // Current position in the buffer
        uint64 pos = initial_pos;

        // Sanity checks
        if (pos + len < pos) {
            return (false, pos, instance);
        }

        while (pos - initial_pos < len) {
            // Decode the key (field number and wire type)
            bool success;
            uint64 field_number;
            ProtobufLib.WireType wire_type;
            (success, pos, field_number, wire_type) = ProtobufLib.decode_key(
                pos,
                buf
            );
            if (!success) {
                return (false, pos, instance);
            }

            // Check that the field number is within bounds
            if (field_number > 2) {
                return (false, pos, instance);
            }

            // Check that the field number of monotonically increasing
            if (field_number <= previous_field_number) {
                return (false, pos, instance);
            }

            // Check that the wire type is correct
            success = check_key(field_number, wire_type);
            if (!success) {
                return (false, pos, instance);
            }

            // Actually decode the field
            (success, pos) = decode_field(pos, buf, field_number, instance);
            if (!success) {
                return (false, pos, instance);
            }

            previous_field_number = field_number;
        }

        // Decoding must have consumed len bytes
        if (pos != initial_pos + len) {
            return (false, pos, instance);
        }

        return (true, pos, instance);
    }

    function check_key(
        uint64 field_number,
        ProtobufLib.WireType wire_type
    ) internal pure returns (bool) {
        if (field_number == 1) {
            return wire_type == ProtobufLib.WireType.LengthDelimited;
        }

        if (field_number == 2) {
            return wire_type == ProtobufLib.WireType.LengthDelimited;
        }

        return false;
    }

    function decode_field(
        uint64 initial_pos,
        bytes memory buf,
        uint64 field_number,
        CanonicalBlockID memory instance
    ) internal pure returns (bool, uint64) {
        uint64 pos = initial_pos;

        if (field_number == 1) {
            bool success;
            (success, pos) = decode_1(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 2) {
            bool success;
            (success, pos) = decode_2(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        return (false, pos);
    }

    // CanonicalBlockID.hash
    function decode_1(
        uint64 pos,
        bytes memory buf,
        CanonicalBlockID memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        uint64 len;
        (success, pos, len) = ProtobufLib.decode_bytes(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (len == 0) {
            return (false, pos);
        }

        instance.hash = new bytes(len);
        for (uint64 i = 0; i < len; i++) {
            instance.hash[i] = buf[pos + i];
        }

        pos = pos + len;

        return (true, pos);
    }

    // CanonicalBlockID.part_set_header
    function decode_2(
        uint64 pos,
        bytes memory buf,
        CanonicalBlockID memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        uint64 len;
        (success, pos, len) = ProtobufLib.decode_embedded_message(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (len == 0) {
            return (false, pos);
        }

        CanonicalPartSetHeader memory nestedInstance;
        (success, pos, nestedInstance) = CanonicalPartSetHeaderCodec.decode(
            pos,
            buf,
            len
        );
        if (!success) {
            return (false, pos);
        }

        instance.part_set_header = nestedInstance;

        return (true, pos);
    }

    // Holds encoded version of message
    struct CanonicalBlockID__Encoded {
        bytes hash__Key;
        bytes hash__Length;
        bytes hash;
        CanonicalPartSetHeaderCodec.CanonicalPartSetHeader__Encoded__Nested part_set_header;
        bytes part_set_header__Encoded;
    }

    // Holds encoded version of nested message
    struct CanonicalBlockID__Encoded__Nested {
        bytes key;
        bytes length;
        bytes nestedInstance;
    }

    function encode(
        CanonicalBlockID memory instance
    ) internal pure returns (bytes memory) {
        CanonicalBlockID__Encoded memory encodedInstance;
        uint64 len;
        uint64 index;

        // Omit encoding hash if default value
        if (bytes(instance.hash).length > 0) {
            // Encode key for hash
            encodedInstance.hash__Key = ProtobufLib.encode_key(
                1,
                uint64(ProtobufLib.WireType.LengthDelimited)
            );
            // Encode hash
            encodedInstance.hash__Length = ProtobufLib.encode_uint64(
                uint64(bytes(instance.hash).length)
            );
            encodedInstance.hash = bytes(instance.hash);
        }

        // Encode part_set_header
        encodedInstance.part_set_header = CanonicalPartSetHeaderCodec
            .encodeNested(2, instance.part_set_header);
        encodedInstance.part_set_header__Encoded = abi.encodePacked(
            encodedInstance.part_set_header.key,
            encodedInstance.part_set_header.length,
            encodedInstance.part_set_header.nestedInstance
        );

        bytes memory finalEncoded;
        index = 0;
        len = 0;
        len += uint64(encodedInstance.hash.length);
        len += uint64(encodedInstance.part_set_header__Encoded.length);
        finalEncoded = new bytes(len);

        uint64 j;
        j = 0;
        while (j < encodedInstance.hash.length) {
            finalEncoded[index++] = encodedInstance.hash[j];
        }
        j = 0;
        while (j < encodedInstance.part_set_header__Encoded.length) {
            finalEncoded[index++] = encodedInstance.part_set_header__Encoded[j];
        }

        return finalEncoded;
    }

    // Encode a nested CanonicalBlockID, wrapped in key and length if non-default
    function encodeNested(
        uint64 field_number,
        CanonicalBlockID memory instance
    ) internal pure returns (CanonicalBlockID__Encoded__Nested memory) {
        CanonicalBlockID__Encoded__Nested memory wrapped;

        wrapped.nestedInstance = encode(instance);

        uint64 len = uint64(wrapped.nestedInstance.length);
        if (len > 0) {
            wrapped.key = ProtobufLib.encode_key(field_number, 2);
            wrapped.length = ProtobufLib.encode_uint64(len);
        }

        return wrapped;
    }
}

struct CanonicalPartSetHeader {
    uint32 total;
    bytes hash;
}

library CanonicalPartSetHeaderCodec {
    function decode(
        uint64 initial_pos,
        bytes memory buf,
        uint64 len
    ) internal pure returns (bool, uint64, CanonicalPartSetHeader memory) {
        // Message instance
        CanonicalPartSetHeader memory instance;
        // Previous field number
        uint64 previous_field_number = 0;
        // Current position in the buffer
        uint64 pos = initial_pos;

        // Sanity checks
        if (pos + len < pos) {
            return (false, pos, instance);
        }

        while (pos - initial_pos < len) {
            // Decode the key (field number and wire type)
            bool success;
            uint64 field_number;
            ProtobufLib.WireType wire_type;
            (success, pos, field_number, wire_type) = ProtobufLib.decode_key(
                pos,
                buf
            );
            if (!success) {
                return (false, pos, instance);
            }

            // Check that the field number is within bounds
            if (field_number > 2) {
                return (false, pos, instance);
            }

            // Check that the field number of monotonically increasing
            if (field_number <= previous_field_number) {
                return (false, pos, instance);
            }

            // Check that the wire type is correct
            success = check_key(field_number, wire_type);
            if (!success) {
                return (false, pos, instance);
            }

            // Actually decode the field
            (success, pos) = decode_field(pos, buf, field_number, instance);
            if (!success) {
                return (false, pos, instance);
            }

            previous_field_number = field_number;
        }

        // Decoding must have consumed len bytes
        if (pos != initial_pos + len) {
            return (false, pos, instance);
        }

        return (true, pos, instance);
    }

    function check_key(
        uint64 field_number,
        ProtobufLib.WireType wire_type
    ) internal pure returns (bool) {
        if (field_number == 1) {
            return wire_type == ProtobufLib.WireType.Varint;
        }

        if (field_number == 2) {
            return wire_type == ProtobufLib.WireType.LengthDelimited;
        }

        return false;
    }

    function decode_field(
        uint64 initial_pos,
        bytes memory buf,
        uint64 field_number,
        CanonicalPartSetHeader memory instance
    ) internal pure returns (bool, uint64) {
        uint64 pos = initial_pos;

        if (field_number == 1) {
            bool success;
            (success, pos) = decode_1(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 2) {
            bool success;
            (success, pos) = decode_2(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        return (false, pos);
    }

    // CanonicalPartSetHeader.total
    function decode_1(
        uint64 pos,
        bytes memory buf,
        CanonicalPartSetHeader memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        uint32 v;
        (success, pos, v) = ProtobufLib.decode_uint32(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (v == 0) {
            return (false, pos);
        }

        instance.total = v;

        return (true, pos);
    }

    // CanonicalPartSetHeader.hash
    function decode_2(
        uint64 pos,
        bytes memory buf,
        CanonicalPartSetHeader memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        uint64 len;
        (success, pos, len) = ProtobufLib.decode_bytes(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (len == 0) {
            return (false, pos);
        }

        instance.hash = new bytes(len);
        for (uint64 i = 0; i < len; i++) {
            instance.hash[i] = buf[pos + i];
        }

        pos = pos + len;

        return (true, pos);
    }

    // Holds encoded version of message
    struct CanonicalPartSetHeader__Encoded {
        bytes total__Key;
        bytes total;
        bytes hash__Key;
        bytes hash__Length;
        bytes hash;
    }

    // Holds encoded version of nested message
    struct CanonicalPartSetHeader__Encoded__Nested {
        bytes key;
        bytes length;
        bytes nestedInstance;
    }

    function encode(
        CanonicalPartSetHeader memory instance
    ) internal pure returns (bytes memory) {
        CanonicalPartSetHeader__Encoded memory encodedInstance;
        uint64 len;
        uint64 index;

        // Omit encoding total if default value
        if (uint64(instance.total) != 0) {
            // Encode key for total
            encodedInstance.total__Key = ProtobufLib.encode_key(
                1,
                uint64(ProtobufLib.WireType.Varint)
            );
            // Encode total
            encodedInstance.total = ProtobufLib.encode_uint32(instance.total);
        }

        // Omit encoding hash if default value
        if (bytes(instance.hash).length > 0) {
            // Encode key for hash
            encodedInstance.hash__Key = ProtobufLib.encode_key(
                2,
                uint64(ProtobufLib.WireType.LengthDelimited)
            );
            // Encode hash
            encodedInstance.hash__Length = ProtobufLib.encode_uint64(
                uint64(bytes(instance.hash).length)
            );
            encodedInstance.hash = bytes(instance.hash);
        }

        bytes memory finalEncoded;
        index = 0;
        len = 0;
        len += uint64(encodedInstance.total.length);
        len += uint64(encodedInstance.hash.length);
        finalEncoded = new bytes(len);

        uint64 j;
        j = 0;
        while (j < encodedInstance.total.length) {
            finalEncoded[index++] = encodedInstance.total[j];
        }
        j = 0;
        while (j < encodedInstance.hash.length) {
            finalEncoded[index++] = encodedInstance.hash[j];
        }

        return finalEncoded;
    }

    // Encode a nested CanonicalPartSetHeader, wrapped in key and length if non-default
    function encodeNested(
        uint64 field_number,
        CanonicalPartSetHeader memory instance
    ) internal pure returns (CanonicalPartSetHeader__Encoded__Nested memory) {
        CanonicalPartSetHeader__Encoded__Nested memory wrapped;

        wrapped.nestedInstance = encode(instance);

        uint64 len = uint64(wrapped.nestedInstance.length);
        if (len > 0) {
            wrapped.key = ProtobufLib.encode_key(field_number, 2);
            wrapped.length = ProtobufLib.encode_uint64(len);
        }

        return wrapped;
    }
}

struct CanonicalVote {
    SignedMsgType ty;
    int64 height;
    int64 round;
    CanonicalBlockID block_id;
    Timestamp timestamp;
    string chain_id;
}

library CanonicalVoteCodec {
    function decode(
        uint64 initial_pos,
        bytes memory buf,
        uint64 len
    ) internal pure returns (bool, uint64, CanonicalVote memory) {
        // Message instance
        CanonicalVote memory instance;
        // Previous field number
        uint64 previous_field_number = 0;
        // Current position in the buffer
        uint64 pos = initial_pos;

        // Sanity checks
        if (pos + len < pos) {
            return (false, pos, instance);
        }

        while (pos - initial_pos < len) {
            // Decode the key (field number and wire type)
            bool success;
            uint64 field_number;
            ProtobufLib.WireType wire_type;
            (success, pos, field_number, wire_type) = ProtobufLib.decode_key(
                pos,
                buf
            );
            if (!success) {
                return (false, pos, instance);
            }

            // Check that the field number is within bounds
            if (field_number > 6) {
                return (false, pos, instance);
            }

            // Check that the field number of monotonically increasing
            if (field_number <= previous_field_number) {
                return (false, pos, instance);
            }

            // Check that the wire type is correct
            success = check_key(field_number, wire_type);
            if (!success) {
                return (false, pos, instance);
            }

            // Actually decode the field
            (success, pos) = decode_field(pos, buf, field_number, instance);
            if (!success) {
                return (false, pos, instance);
            }

            previous_field_number = field_number;
        }

        // Decoding must have consumed len bytes
        if (pos != initial_pos + len) {
            return (false, pos, instance);
        }

        return (true, pos, instance);
    }

    function check_key(
        uint64 field_number,
        ProtobufLib.WireType wire_type
    ) internal pure returns (bool) {
        if (field_number == 1) {
            return wire_type == ProtobufLib.WireType.Varint;
        }

        if (field_number == 2) {
            return wire_type == ProtobufLib.WireType.Bits64;
        }

        if (field_number == 3) {
            return wire_type == ProtobufLib.WireType.Bits64;
        }

        if (field_number == 4) {
            return wire_type == ProtobufLib.WireType.LengthDelimited;
        }

        if (field_number == 5) {
            return wire_type == ProtobufLib.WireType.LengthDelimited;
        }

        if (field_number == 6) {
            return wire_type == ProtobufLib.WireType.LengthDelimited;
        }

        return false;
    }

    function decode_field(
        uint64 initial_pos,
        bytes memory buf,
        uint64 field_number,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        uint64 pos = initial_pos;

        if (field_number == 1) {
            bool success;
            (success, pos) = decode_1(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 2) {
            bool success;
            (success, pos) = decode_2(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 3) {
            bool success;
            (success, pos) = decode_3(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 4) {
            bool success;
            (success, pos) = decode_4(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 5) {
            bool success;
            (success, pos) = decode_5(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        if (field_number == 6) {
            bool success;
            (success, pos) = decode_6(pos, buf, instance);
            if (!success) {
                return (false, pos);
            }

            return (true, pos);
        }

        return (false, pos);
    }

    // CanonicalVote.ty
    function decode_1(
        uint64 pos,
        bytes memory buf,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        int32 v;
        (success, pos, v) = ProtobufLib.decode_enum(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (v == 0) {
            return (false, pos);
        }

        // Check that value is within enum range
        if (v < 0 || v > 2) {
            return (false, pos);
        }

        instance.ty = SignedMsgType(v);

        return (true, pos);
    }

    // CanonicalVote.height
    function decode_2(
        uint64 pos,
        bytes memory buf,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        int64 v;
        (success, pos, v) = ProtobufLib.decode_sfixed64(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (v == 0) {
            return (false, pos);
        }

        instance.height = v;

        return (true, pos);
    }

    // CanonicalVote.round
    function decode_3(
        uint64 pos,
        bytes memory buf,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        int64 v;
        (success, pos, v) = ProtobufLib.decode_sfixed64(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (v == 0) {
            return (false, pos);
        }

        instance.round = v;

        return (true, pos);
    }

    // CanonicalVote.block_id
    function decode_4(
        uint64 pos,
        bytes memory buf,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        uint64 len;
        (success, pos, len) = ProtobufLib.decode_embedded_message(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (len == 0) {
            return (false, pos);
        }

        CanonicalBlockID memory nestedInstance;
        (success, pos, nestedInstance) = CanonicalBlockIDCodec.decode(
            pos,
            buf,
            len
        );
        if (!success) {
            return (false, pos);
        }

        instance.block_id = nestedInstance;

        return (true, pos);
    }

    // CanonicalVote.timestamp
    function decode_5(
        uint64 pos,
        bytes memory buf,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        uint64 len;
        (success, pos, len) = ProtobufLib.decode_embedded_message(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (len == 0) {
            return (false, pos);
        }

        Timestamp memory nestedInstance;
        (success, pos, nestedInstance) = TimestampCodec.decode(pos, buf, len);
        if (!success) {
            return (false, pos);
        }

        instance.timestamp = nestedInstance;

        return (true, pos);
    }

    // CanonicalVote.chain_id
    function decode_6(
        uint64 pos,
        bytes memory buf,
        CanonicalVote memory instance
    ) internal pure returns (bool, uint64) {
        bool success;

        string memory v;
        (success, pos, v) = ProtobufLib.decode_string(pos, buf);
        if (!success) {
            return (false, pos);
        }

        // Default value must be omitted
        if (bytes(v).length == 0) {
            return (false, pos);
        }

        instance.chain_id = v;

        return (true, pos);
    }

    // Holds encoded version of message
    struct CanonicalVote__Encoded {
        bytes ty__Key;
        bytes ty;
        bytes height__Key;
        bytes height;
        bytes round__Key;
        bytes round;
        CanonicalBlockIDCodec.CanonicalBlockID__Encoded__Nested block_id;
        bytes block_id__Encoded;
        TimestampCodec.Timestamp__Encoded__Nested timestamp;
        bytes timestamp__Encoded;
        bytes chain_id__Key;
        bytes chain_id__Length;
        bytes chain_id;
    }

    // Holds encoded version of nested message
    struct CanonicalVote__Encoded__Nested {
        bytes key;
        bytes length;
        bytes nestedInstance;
    }

    function encode(
        CanonicalVote memory instance
    ) internal pure returns (bytes memory) {
        CanonicalVote__Encoded memory encodedInstance;
        uint64 len;
        uint64 index;

        // Omit encoding ty if default value
        if (uint64(instance.ty) != 0) {
            // Encode key for ty
            encodedInstance.ty__Key = ProtobufLib.encode_key(
                1,
                uint64(ProtobufLib.WireType.Varint)
            );
            // Encode ty
            encodedInstance.ty = ProtobufLib.encode_enum(
                int32(uint32(instance.ty))
            );
        }

        // Omit encoding height if default value
        if (uint64(instance.height) != 0) {
            // Encode key for height
            encodedInstance.height__Key = ProtobufLib.encode_key(
                2,
                uint64(ProtobufLib.WireType.Bits64)
            );
            // Encode height
            encodedInstance.height = ProtobufLib.encode_sfixed64(
                instance.height
            );
        }

        // Omit encoding round if default value
        if (uint64(instance.round) != 0) {
            // Encode key for round
            encodedInstance.round__Key = ProtobufLib.encode_key(
                3,
                uint64(ProtobufLib.WireType.Bits64)
            );
            // Encode round
            encodedInstance.round = ProtobufLib.encode_sfixed64(instance.round);
        }

        // Encode block_id
        encodedInstance.block_id = CanonicalBlockIDCodec.encodeNested(
            4,
            instance.block_id
        );
        encodedInstance.block_id__Encoded = abi.encodePacked(
            encodedInstance.block_id.key,
            encodedInstance.block_id.length,
            encodedInstance.block_id.nestedInstance
        );

        // Encode timestamp
        encodedInstance.timestamp = TimestampCodec.encodeNested(
            5,
            instance.timestamp
        );
        encodedInstance.timestamp__Encoded = abi.encodePacked(
            encodedInstance.timestamp.key,
            encodedInstance.timestamp.length,
            encodedInstance.timestamp.nestedInstance
        );

        // Omit encoding chain_id if default value
        if (bytes(instance.chain_id).length > 0) {
            // Encode key for chain_id
            encodedInstance.chain_id__Key = ProtobufLib.encode_key(
                6,
                uint64(ProtobufLib.WireType.LengthDelimited)
            );
            // Encode chain_id
            encodedInstance.chain_id__Length = ProtobufLib.encode_uint64(
                uint64(bytes(instance.chain_id).length)
            );
            encodedInstance.chain_id = bytes(instance.chain_id);
        }

        bytes memory finalEncoded;
        index = 0;
        len = 0;
        len += uint64(encodedInstance.ty.length);
        len += uint64(encodedInstance.height.length);
        len += uint64(encodedInstance.round.length);
        len += uint64(encodedInstance.block_id__Encoded.length);
        len += uint64(encodedInstance.timestamp__Encoded.length);
        len += uint64(encodedInstance.chain_id.length);
        finalEncoded = new bytes(len);

        uint64 j;
        j = 0;
        while (j < encodedInstance.ty.length) {
            finalEncoded[index++] = encodedInstance.ty[j];
        }
        j = 0;
        while (j < encodedInstance.height.length) {
            finalEncoded[index++] = encodedInstance.height[j];
        }
        j = 0;
        while (j < encodedInstance.round.length) {
            finalEncoded[index++] = encodedInstance.round[j];
        }
        j = 0;
        while (j < encodedInstance.block_id__Encoded.length) {
            finalEncoded[index++] = encodedInstance.block_id__Encoded[j];
        }
        j = 0;
        while (j < encodedInstance.timestamp__Encoded.length) {
            finalEncoded[index++] = encodedInstance.timestamp__Encoded[j];
        }
        j = 0;
        while (j < encodedInstance.chain_id.length) {
            finalEncoded[index++] = encodedInstance.chain_id[j];
        }

        return finalEncoded;
    }

    // Encode a nested CanonicalVote, wrapped in key and length if non-default
    function encodeNested(
        uint64 field_number,
        CanonicalVote memory instance
    ) internal pure returns (CanonicalVote__Encoded__Nested memory) {
        CanonicalVote__Encoded__Nested memory wrapped;

        wrapped.nestedInstance = encode(instance);

        uint64 len = uint64(wrapped.nestedInstance.length);
        if (len > 0) {
            wrapped.key = ProtobufLib.encode_key(field_number, 2);
            wrapped.length = ProtobufLib.encode_uint64(len);
        }

        return wrapped;
    }
}