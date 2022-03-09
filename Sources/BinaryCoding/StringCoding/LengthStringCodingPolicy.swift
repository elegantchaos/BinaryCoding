// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/03/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public struct LengthStringCodingPolicy {
    public let encoding: String.Encoding

    public init(encoding: String.Encoding) {
        self.encoding = encoding
    }
}

extension LengthStringCodingPolicy: StringDecodingPolicy {
    public func decodeString(with decoder: BinaryDecoder) throws -> String {
        let length = try decoder.decode(UInt32.self)
        let data = try decoder.decodeArray(of: UInt8.self, count: Int(length))
        guard let string = String(bytes: data, encoding: encoding) else {
            throw BinaryCodingError.badStringEncoding
        }
        
        return string
    }
}

extension LengthStringCodingPolicy: StringEncodingPolicy {
    public func encodeString(_ string: String, to encoder: BinaryEncoder) throws {
        guard let bytes = string.data(using: encoding) else {
            throw BinaryCodingError.badStringEncoding
        }
        
        try UInt32(bytes.count).encode(to: encoder)
        try bytes.encode(to: encoder)
    }
}
