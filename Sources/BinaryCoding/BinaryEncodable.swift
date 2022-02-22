// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

public protocol BinaryEncoder: Encoder {
    var stringEncoding: String.Encoding { get }
}

public protocol BinaryEncodable: Encodable {
    func binaryEncode(to encoder: BinaryEncoder) throws
}

public extension BinaryEncodable {
    func binaryEncode(to encoder: BinaryEncoder) throws {
        try encode(to: encoder)
    }
}

enum BinaryEncodingError: Error {
    case couldntEncodeString
}
