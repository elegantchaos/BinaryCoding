// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import BinaryCoding

final class NestedCodingTests: XCTestCase {
    struct Inner: BinaryCodable, Equatable{
        let string: String
        let int: Int
    }
    
    struct Middle: BinaryCodable, Equatable {
        let inner: Inner
        let array: [Inner]
    }
    
    struct Compound: BinaryCodable, Equatable {
        let int: Int
        let string: String
        let middle: Middle
    }

    func testEncoding() throws {
        let value = Compound(int: 0x123456789ABCDEF, string: "Outer", middle: .init(inner: .init(string: "Inner", int: 0x123456789ABCDEF), array: [.init(string: "Array", int: 0x123456789ABCDEF)]))
        let encoder = DataEncoder()
        let expected = Data([0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01, 0x4F, 0x75, 0x74, 0x65, 0x72, 0x00, 0x49, 0x6E, 0x6E, 0x65, 0x72, 0x00, 0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01, 0x41, 0x72, 0x72, 0x61, 0x79, 0x00, 0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01])
        let data = try encoder.encode(value)
        
        var s: [String] = []
        for byte in data {
            s.append(String(format: "0x%02X", byte))
        }
        print(s.joined(separator: ", "))
        XCTAssertEqual(data, expected)
    }

    func testDecoding() throws {
        let expected = Compound(int: 0x123456789ABCDEF, string: "Outer", middle: .init(inner: .init(string: "Inner", int: 0x123456789ABCDEF), array: [.init(string: "Array", int: 0x123456789ABCDEF)]))
        let data = Data([0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01, 0x4F, 0x75, 0x74, 0x65, 0x72, 0x00, 0x49, 0x6E, 0x6E, 0x65, 0x72, 0x00, 0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01, 0x41, 0x72, 0x72, 0x61, 0x79, 0x00, 0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01])
        let decoder = DataDecoder(data: data)
        
        let decoded = try decoder.decode(Compound.self)
        
        XCTAssertEqual(decoded, expected)
    }

}
