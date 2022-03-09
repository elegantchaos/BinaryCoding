// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/03/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

/// Encodes/decodes strings with as 4-byte little-endian length, followed by the encoded string data.
public struct LengthStringCoder {
    public let encoding: String.Encoding

    public init(encoding: String.Encoding) {
        self.encoding = encoding
    }
}

extension LengthStringCoder: StringDecodingPolicy {
    public func decodeString(with decoder: BinaryDecoder) throws -> String {
        let length = try decoder.decode(UInt32.self)
        let data = try decoder.decodeArray(of: UInt8.self, count: Int(length))
        guard let string = String(bytes: data, encoding: encoding) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Couldn't decode string as \(encoding)"))
        }
        
        return string
    }
}

extension LengthStringCoder: StringEncodingPolicy {
    public func encodeString(_ string: String, to encoder: BinaryEncoder) throws {
        guard let bytes = string.data(using: encoding) else {
            throw EncodingError.invalidValue(string, .init(codingPath: encoder.codingPath, debugDescription: "Couldn't encode \(string) as \(encoding)"))
        }
        
        try UInt32(bytes.count).encode(to: encoder)
        try bytes.encode(to: encoder)
    }
}
