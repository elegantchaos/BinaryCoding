// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension String: BinaryCodable {
    public init(fromBinary decoder: BinaryDecoder) throws {
        self = try decoder.stringDecodingPolicy.decodeString(with: decoder)
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
