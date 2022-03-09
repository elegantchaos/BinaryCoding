// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import BinaryCoding

final class StringCodingTests: XCTestCase {
    struct Compound: BinaryCodable, Equatable {
        let byte: UInt8
        let string: String
        
        init(string: String) {
            self.string = string
            self.byte = 0x12
        }
    }

    func testEncodeStringUTF8() throws {
        let encoder = DataEncoder()
        
        let expected = Data([0x54, 0x65, 0x73, 0x74, 0x00])
        XCTAssertEqual(try encoder.encode("Test"), expected)
    }

    func testEncodeStringUTF16() throws {
        let encoder = DataEncoder()
        encoder.stringEncoding = .utf16
        
        let expected = Data([0x0A, 0x00, 0x00, 0x00, 0xFF, 0xFE, 0x54, 0x00, 0x65, 0x00, 0x73, 0x00, 0x74, 0x00])
        XCTAssertEqual(try encoder.encode("Test"), expected)

    }

    func testEncodeCompoundStringUTF8() throws {
        let encoder = DataEncoder()
        
        let expected = Data([0x12, 0x54, 0x65, 0x73, 0x74, 0x00])
        XCTAssertEqual(try encoder.encode(Compound(string: "Test")), expected)
    }

    func testEncodeCompoundStringUTF16() throws {
        let encoder = DataEncoder()
        encoder.stringEncoding = .utf16
        
        let expected = Data([0x12, 0x0A, 0x00, 0x00, 0x00, 0xFF, 0xFE, 0x54, 0x00, 0x65, 0x00, 0x73, 0x00, 0x74, 0x00])
        XCTAssertEqual(try encoder.encode(Compound(string: "Test")), expected)

    }
    
    
    func testDecodeStringUTF8() throws {
        let data = Data([0x54, 0x65, 0x73, 0x74, 0x00])
        let decoder = DataDecoder(data: data)
        
        XCTAssertEqual(try decoder.decode(String.self), "Test")
    }

    func testDecodeCompoundStringUTF8() throws {
        let data = Data([0x12, 0x54, 0x65, 0x73, 0x74, 0x00])
        let decoder = DataDecoder(data: data)
        
        XCTAssertEqual(try decoder.decode(Compound.self), Compound(string: "Test"))
    }

    func testDecodeStringUTF16() throws {
        let data = Data([0x0A, 0x00, 0x00, 0x00, 0xFF, 0xFE, 0x54, 0x00, 0x65, 0x00, 0x73, 0x00, 0x74, 0x00])
        let decoder = DataDecoder(data: data)

        decoder.stringDecodingPolicy = LengthStringDecodingPolicy(encoding: .utf16)
        
        XCTAssertEqual(try decoder.decode(String.self), "Test")

    }

    func testDecodeCompoundStringUTF16() throws {
        let data = Data([0x12, 0x0A, 0x00, 0x00, 0x00, 0xFF, 0xFE, 0x54, 0x00, 0x65, 0x00, 0x73, 0x00, 0x74, 0x00])
        let decoder = DataDecoder(data: data)
        decoder.stringDecodingPolicy = LengthStringDecodingPolicy(encoding: .utf16)
        
        XCTAssertEqual(try decoder.decode(Compound.self), Compound(string: "Test"))
    }
}

