// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/03/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public protocol StringDecodingPolicy {
    func decodeString(with decoder: BinaryDecoder) throws -> String
}

public protocol StringEncodingPolicy {
    func encodeString(_ string: String, to encoder: BinaryEncoder) throws
}
