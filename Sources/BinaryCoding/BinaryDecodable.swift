// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

public protocol BinaryDecoder: Decoder {
    var stringEncoding: String.Encoding { get }
}

public protocol BinaryDecodable: Decodable {
    init(fromBinary: BinaryDecoder) throws
}

public extension BinaryDecodable {
    init(fromBinary decoder: BinaryDecoder) throws {
        print("fallback binary decoding for \(Self.self)")
        
        try self.init(from: decoder)
    }
}
