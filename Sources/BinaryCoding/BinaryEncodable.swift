// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

public protocol BinaryEncoder: Encoder {
    var stringEncodingPolicy: StringEncodingPolicy { get }
}

public protocol BinaryEncodable: Encodable {
    func binaryEncode(to encoder: BinaryEncoder) throws
}

public extension BinaryEncodable {
    /// Binary encode this item by falling back to the normal
    /// encode method.
    ///
    /// Types that want to provide different encoding behaviour
    /// for binary coders should provide their own implementation
    /// of this method.
    func binaryEncode(to encoder: BinaryEncoder) throws {
        try encode(to: encoder)
    }
}

public extension Encodable {
    /// Binary encode this item if possible, otherwise encode it normally.
    /// Performs a dynamic check to see if the item and encoder support
    /// binary encoding. If not, calls the normal encode method.
    func binaryEncode(to encoder: Encoder) throws {
        if let bc = self as? BinaryCodable, let be = encoder as? BinaryEncoder {
            try bc.binaryEncode(to: be)
        } else {
            try encode(to: encoder)
        }
    }
}
