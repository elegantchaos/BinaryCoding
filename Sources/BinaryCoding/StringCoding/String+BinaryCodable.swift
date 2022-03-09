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
        try encoder.stringEncodingPolicy.encodeString(self, to: encoder)
    }
}
