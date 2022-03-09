// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/03/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public struct ZeroTerminatedStringCodingPolicy {
    public let encoding: String.Encoding

    public init(encoding: String.Encoding) {
        self.encoding = encoding
    }
}

extension ZeroTerminatedStringCodingPolicy: StringDecodingPolicy {
    public func decodeString(with decoder: BinaryDecoder) throws -> String {
        var bytes: [UInt8] = []
        while let byte = try? decoder.decode(UInt8.self), byte != 0 {
            bytes.append(byte)
        }
        
        guard let string = String(bytes: bytes, encoding: encoding) else {
            throw BinaryCodingError.badStringEncoding
        }
        
        return string
    }
}

extension ZeroTerminatedStringCodingPolicy: StringEncodingPolicy {
    public func encodeString(_ string: String, to encoder: BinaryEncoder) throws {
        guard let bytes = string.data(using: encoding) else {
            throw EncodingError.invalidValue(string, .init(codingPath: encoder.codingPath, debugDescription: "Couldn't encode \(string) as \(encoding)"))
        }
        
        try bytes.encode(to: encoder)
        try UInt8(0).encode(to: encoder)
    }
}

/*
 var container = encoder.unkeyedContainer()
 guard let bytes = data(using: encoder.stringEncoding) else {
     throw EncodingError.invalidValue(self, .init(codingPath: encoder.codingPath, debugDescription: "Couldn't encode \(self) as \(encoder.stringEncoding)"))
 }

 try container.encode(bytes)
 try container.encode(UInt8(0))

 */
