// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import BinaryCoding

final class FloatCodingTests: XCTestCase {
    func testEncodeDouble() throws {
        
        let encoder = DataEncoder()
        let expected = Data([0xAE, 0x47, 0xE1, 0x7A, 0x14, 0xAE, 0xF3, 0x3F])
        XCTAssertEqual(try encoder.encode(Double(1.23)), expected)
    }

    func testEncodeFloat() throws {
        
        let encoder = DataEncoder()
        let expected = Data([0xA4, 0x70, 0x9D, 0x3F])
        XCTAssertEqual(try encoder.encode(Float(1.23)), expected)
    }

    func testEncodeFloat16() throws {
        
        let encoder = DataEncoder()
        let expected = Data([0xEC, 0x3C])
        XCTAssertEqual(try encoder.encode(Float16(1.23)), expected)
    }


    func testDecodeDouble() throws {
        let data = Data([0xAE, 0x47, 0xE1, 0x7A, 0x14, 0xAE, 0xF3, 0x3F])
        let decoder = DataDecoder(data: data)
        
        XCTAssertEqual(try decoder.decode(Double.self), 1.23)
    }

    func testDecodeFloat() throws {
        let data = Data([0xA4, 0x70, 0x9D, 0x3F])
        let decoder = DataDecoder(data: data)
        
        XCTAssertEqual(try decoder.decode(Float.self), 1.23)
    }

    func testDecodeFloat16() throws {
        let data = Data([0xEC, 0x3C])
        let decoder = DataDecoder(data: data)
        
        XCTAssertEqual(try decoder.decode(Float16.self), Float16(1.23))
    }

}
