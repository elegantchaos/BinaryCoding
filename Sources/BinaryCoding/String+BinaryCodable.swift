// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension String: BinaryCodable {
    public init(fromBinary decoder: BinaryDecoder) throws {
        let container = try decoder.singleValueContainer()
        self = try container.decode(String.self)
    }
    
    public func binaryEncode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(data(using: .ascii))
        try container.encode(UInt8(0))
    }
}
