# BinaryCoding

Adds support for using Swift's `Codable` to encode/decode objects and structs to/from binday data.

Adds Data-based encoders and decoders which can be used to code any codable object out-of-the-box.

Also adds `BinaryEncodable` and `BinaryDecodable` protocols which entities can adopt if they want to provide an alternative binary encoding or decoding scheme. 

This is useful for example when you need to support coding with a compact binary format, but also want to provide a cleaner JSON coding. You can let Swift's native coding support handle the JSON, and provide custom `init(fromBinary:)` or `binaryEncode(to:)` implementations for the binary support.

