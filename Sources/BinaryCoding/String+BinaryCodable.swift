// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension String: BinaryCodable {
    public init(fromBinary decoder: BinaryDecoder) throws {
        var container = try decoder.unkeyedContainer()

        let encoding = decoder.stringEncoding
        switch encoding {
            case .utf16, .utf16BigEndian, .utf16LittleEndian, .utf32, .utf32BigEndian, .utf32LittleEndian:
                let length = try container.decode(UInt32.self)
                let data = try container.decodeArray(of: UInt8.self, count: length)
                guard let string = String(bytes: data, encoding: encoding) else { throw BinaryCodingError.badStringEncoding }
                self = string

            default:
                var bytes: [UInt8] = []
                while let byte = try? decoder.decode(UInt8.self), byte != 0 {
                    bytes.append(byte)
                }
                guard let string = String(bytes: bytes, encoding: encoding) else { throw BinaryCodingError.badStringEncoding }
                self = string
        }

    }
    public func binaryEncode(to encoder: BinaryEncoder) throws {
        var container = encoder.unkeyedContainer()
        guard let bytes = data(using: encoder.stringEncoding) else {
            throw EncodingError.invalidValue(self, .init(codingPath: encoder.codingPath, debugDescription: "Couldn't encode \(self) as \(encoder.stringEncoding)"))
        }

        try container.encode(bytes)
        try container.encode(UInt8(0))
    }
}
