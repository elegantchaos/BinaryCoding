// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension Array: BinaryDecodable where Element: Decodable {
    /// Decode a binary array.
    /// Note that since we don't know how long it is, this
    /// potentially consumes all of the decoder's remaining data
    /// (give or take a few bytes potentially left over at the end).
    ///
    /// It will stop decoding elements as soon as one fails, or it
    /// runs out of data.
    public init(fromBinary decoder: BinaryDecoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: Self = []
        while let element = try? container.decode(Element.self) {
            elements.append(element)
        }
        self = elements
    }
}
