// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import BinaryCoding

final class BinaryCodingTests: XCTestCase {
    func testInt() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0xF0, 0xDE, 0xBC, 0x9A, 0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(Int(0x123456789ABCDEF0)), expected)
    }

    func testInt32() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(Int32(0x12345678)), expected)
    }

    func testInt16() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0x34, 0x12])
        XCTAssertEqual(try encoder.encode(Int16(0x1234)), expected)
    }

    func testInt8() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0x12])
        XCTAssertEqual(try encoder.encode(Int8(0x12)), expected)
    }

    func testUInt() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0xF0, 0xDE, 0xBC, 0x9A, 0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(UInt(0x123456789ABCDEF0)), expected)
    }

    func testUInt32() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(UInt32(0x12345678)), expected)
    }

    func testUInt16() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0x34, 0x12])
        XCTAssertEqual(try encoder.encode(UInt16(0x1234)), expected)
    }

    func testUInt8() throws {
        
        let encoder = BinaryEncoder()
        
        let expected = Data([0x12])
        XCTAssertEqual(try encoder.encode(UInt8(0x12)), expected)
    }

}
