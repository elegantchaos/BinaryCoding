// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public protocol ReadableBinaryStream: BinaryStream {
    func read(_ count: Int) throws -> ArraySlice<UInt8>
    func read(until: UInt8)  throws -> ArraySlice<UInt8>
    func readInt<T>(_ type: T.Type) throws -> T where T: FixedWidthInteger
    func readFloat<T>(_ type: T.Type) throws -> T where T: BinaryFloatingPoint
    func readAll() -> ArraySlice<UInt8>
    func remainingCount() -> Int
    func readDecodable<T>(_ type: T.Type) throws -> T where T: Decodable
}


protocol ReadableBinaryStreamDecodingAdaptor {
    var stream: ReadableBinaryStream { get }
}

extension ReadableBinaryStreamDecodingAdaptor {
    func decodeNil() -> Bool {
        fatalError("to do")
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        let value = try stream.readInt(UInt8.self)
        return value != 0
    }

    func decode(_ type: Double.Type) throws -> Double {
        return try stream.readFloat(type)
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        return try stream.readFloat(type)
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        return try stream.readInt(type)
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        return try stream.readInt(type)
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try stream.readInt(type)
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try stream.readInt(type)
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try stream.readDecodable(type)
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError("to do")
    }
    
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("to do")
    }
    
    func superDecoder() throws -> Decoder {
        fatalError("to do")
    }

}
