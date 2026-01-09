// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

extension Float64: BinaryCodable {}
extension Float32: BinaryCodable {}

extension Float16: BinaryCodable {
    public init(fromBinary decoder: BinaryDecoder) throws {
        let container = try decoder.singleValueContainer()
        let uint16 = try container.decode(UInt16.self)
        self = unsafeBitCast(uint16, to: Float16.self)
    }

    public func binaryEncode(to encoder: BinaryEncoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.littleEndianBytes)
    }
}
