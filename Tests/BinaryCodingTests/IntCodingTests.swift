// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import BinaryCoding

final class IntCodingTests: XCTestCase {
    func testEncodeInt() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0xF0, 0xDE, 0xBC, 0x9A, 0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(Int(0x123456789ABCDEF0)), expected)
    }

    func testEncodeInt32() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(Int32(0x12345678)), expected)
    }

    func testEncodeInt16() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0x34, 0x12])
        XCTAssertEqual(try encoder.encode(Int16(0x1234)), expected)
    }

    func testEncodeInt8() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0x12])
        XCTAssertEqual(try encoder.encode(Int8(0x12)), expected)
    }

    func testEncodeUInt() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0xF0, 0xDE, 0xBC, 0x9A, 0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(UInt(0x123456789ABCDEF0)), expected)
    }

    func testEncodeUInt32() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0x78, 0x56, 0x34, 0x12])
        XCTAssertEqual(try encoder.encode(UInt32(0x12345678)), expected)
    }

    func testEncodeUInt16() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0x34, 0x12])
        XCTAssertEqual(try encoder.encode(UInt16(0x1234)), expected)
    }

    func testEncodeUInt8() throws {
        
        let encoder = DataEncoder()
        
        let expected = Data([0x12])
        XCTAssertEqual(try encoder.encode(UInt8(0x12)), expected)
    }

    func testDecodeInt() throws {
        let data = Data([0xF0, 0xDE, 0xBC, 0x9A, 0x78, 0x56, 0x34, 0x12])
        let decoder = DataDecoder(data: data)
        
        XCTAssertEqual(try decoder.decode(Int.self), 0x123456789ABCDEF0)
    }

    func testDecodeInt32() throws {
        
        let data = Data([0x78, 0x56, 0x34, 0x12])
        let decoder = DataDecoder(data: data)

        XCTAssertEqual(try decoder.decode(Int32.self), 0x12345678)
    }

    func testDecodeInt16() throws {
        
        let data = Data([0x34, 0x12])
        let decoder = DataDecoder(data: data)

        XCTAssertEqual(try decoder.decode(Int16.self), 0x1234)
    }

    func testDecodeInt8() throws {
        
        let data = Data([0x12])
        let decoder = DataDecoder(data: data)
        XCTAssertEqual(try decoder.decode(Int8.self), 0x12)
    }

    func testDecodeUInt() throws {
        
        let data = Data([0xF0, 0xDE, 0xBC, 0x9A, 0x78, 0x56, 0x34, 0x12])
        let decoder = DataDecoder(data: data)

        XCTAssertEqual(try decoder.decode(UInt.self), 0x123456789ABCDEF0)
    }

    func testDecodeUInt32() throws {
        
        let data = Data([0x78, 0x56, 0x34, 0x12])
        let decoder = DataDecoder(data: data)

        XCTAssertEqual(try decoder.decode(UInt32.self), 0x12345678)
    }

    func testDecodeUInt16() throws {
        
        let data = Data([0x34, 0x12])
        let decoder = DataDecoder(data: data)

        XCTAssertEqual(try decoder.decode(UInt16.self), 0x1234)
    }

    func testDecodeUInt8() throws {
        
        let data = Data([0x12])
        let decoder = DataDecoder(data: data)

        XCTAssertEqual(try decoder.decode(UInt8.self), 0x12)
    }

}
