// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/03/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public struct ZeroTerminatedStringCoder {
    public static let defaultInstance = ZeroTerminatedStringCoder(encoding: .utf8)

    public let encoding: String.Encoding

    public init(encoding: String.Encoding) {
        self.encoding = encoding
    }
}

extension ZeroTerminatedStringCoder: StringDecodingPolicy {
    public func decodeString(with decoder: BinaryDecoder) throws -> String {
        var bytes: [UInt8] = []
        while let byte = try? decoder.decode(UInt8.self), byte != 0 {
            bytes.append(byte)
        }
        
        guard let string = String(bytes: bytes, encoding: encoding) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Couldn't decode string as \(encoding)"))
        }
        
        return string
    }
}

extension ZeroTerminatedStringCoder: StringEncodingPolicy {
    public func encodeString(_ string: String, to encoder: BinaryEncoder) throws {
        guard let bytes = string.data(using: encoding) else {
            throw EncodingError.invalidValue(string, .init(codingPath: encoder.codingPath, debugDescription: "Couldn't encode \(string) as \(encoding)"))
        }
        
        try bytes.encode(to: encoder)
        try UInt8(0).encode(to: encoder)
    }
}
