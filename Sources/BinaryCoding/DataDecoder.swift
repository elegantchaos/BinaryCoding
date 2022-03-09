// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

open class DataDecoder: BinaryDecoder, ReadableBinaryStream {
    public let stringDecodingPolicy: StringDecodingPolicy
    public var enableLogging: Bool = false

    public var codingPath: [CodingKey]
    public var userInfo: [CodingUserInfoKey : Any]
    
    var data: Bytes
    var index: Bytes.Index

    public convenience init(data: Data, stringDecodingPolicy: StringDecodingPolicy = ZeroTerminatedStringCodingPolicy(encoding: .utf8)) {
        self.init(bytes: data.littleEndianBytes, stringDecodingPolicy: stringDecodingPolicy)
    }

    public init(bytes: Bytes, stringDecodingPolicy: StringDecodingPolicy = ZeroTerminatedStringCodingPolicy(encoding: .utf8)) {
        self.data = bytes
        self.stringDecodingPolicy = stringDecodingPolicy
        self.index = bytes.startIndex
        self.codingPath = []
        self.userInfo = [:]
    }

    public func decode<T: Decodable>(_ kind: T.Type) throws -> T {
        return try readDecodable(kind)
    }

    public func readDecodable<T: Decodable>(_ kind: T.Type) throws -> T {
        if let binaryDecodable = kind as? BinaryDecodable.Type {
            return try binaryDecodable.init(fromBinary: self) as! T
        } else {
            return try T(from: self)
        }
    }

    public func read(_ count: Int) throws -> ArraySlice<Byte> {
        let end = index.advanced(by: count)
        guard end <= data.endIndex else {
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Out of data. Trying to read \(count) bytes, only have \(end - data.endIndex)."))
        }

        let slice = data[index..<end]
        index = end
        return slice
    }

    public func read(until: Byte)  throws -> ArraySlice<Byte> {
        
        guard let end = data[index...].firstIndex(of: until) else {
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Looking for a byte with value \(until), but run out of data."))
            
        }
        let slice = data[index..<end]
        index = data.index(end, offsetBy: 1)
        return slice
    }
    
    public func readInt<T>(_ type: T.Type) throws -> T where T: FixedWidthInteger {
        let bytes = try read(MemoryLayout<T>.size)
        return try T(littleEndianBytes: bytes)
    }

    public func readFloat<T>(_ type: T.Type) throws -> T where T: BinaryFloatingPoint {
        let bytes = try read(MemoryLayout<T>.size)
        return try T(littleEndianBytes: bytes)
    }
    
    public func readAll() -> ArraySlice<Byte> {
        return data[index...]
    }
    
    public func remainingCount() -> Int {
        data.count - index
    }
    
    public  func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(KeyedContainer(for: self, path: codingPath))
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return UnkeyedContainer(for: self)
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return SingleValueContainer(for: self, path: codingPath)
    }
    
    class KeyedContainer<K>: KeyedDecodingContainerProtocol where K: CodingKey {
        typealias Key = K
        
        var codingPath: [CodingKey]
        var stream: ReadableBinaryStream
        
        init(for stream: ReadableBinaryStream, path: [CodingKey]) {
            self.stream = stream
            self.codingPath = path
        }

        var allKeys: [K] {
            return []
        }
        
        func contains(_ key: K) -> Bool {
            return true // we can't know if the key is present, we have to assume that it is
        }
        
        func decodeNil(forKey key: K) throws -> Bool {
            return false // we can't know if the optional value is present, we have to assume that it is
        }
        
        func decode(_ type: Float.Type, forKey key: K) throws -> Float {
            let bytes = try stream.read(MemoryLayout<Float>.size)
            let raw = try UInt32(littleEndianBytes: bytes)
            let value = Float(bitPattern: raw)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: Int.Type, forKey key: K) throws -> Int {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: Int8.Type, forKey key: K) throws -> Int8 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: Int16.Type, forKey key: K) throws -> Int16 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: Int32.Type, forKey key: K) throws -> Int32 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: Int64.Type, forKey key: K) throws -> Int64 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: UInt.Type, forKey key: K) throws -> UInt {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: UInt8.Type, forKey key: K) throws -> UInt8 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 {
            let value = try stream.readInt(type)
            stream.debugKey(value, key: key)
            return value
        }

        func decode<T>(_ type: T.Type, forKey key: K) throws -> T where T : Decodable {
            stream.pushPath(key)
            let value = try stream.readDecodable(type)
            stream.popPath()

            stream.debugKey(value, key: key)
            return value
        }
        
        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            fatalError("to do")
        }
        
        func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
            fatalError("to do")
        }
        
        func superDecoder() throws -> Decoder {
            fatalError("to do")
        }
        
        func superDecoder(forKey key: K) throws -> Decoder {
            fatalError("to do")
        }
    }

    class UnkeyedContainer: UnkeyedDecodingContainer, ReadableBinaryStreamDecodingAdaptor {
        let stream: ReadableBinaryStream
        
        var codingPath: [CodingKey]
        
        var count: Int?
        
        var isAtEnd: Bool
        
        var currentIndex: Int

        init(for decoder: ReadableBinaryStream) {
            self.stream = decoder
            self.codingPath = []
            self.count = nil
            self.currentIndex = 0
            self.isAtEnd = false
        }
    }

    class SingleValueContainer: SingleValueDecodingContainer, ReadableBinaryStreamDecodingAdaptor {
        var stream: ReadableBinaryStream
        var codingPath: [CodingKey]
        
        init(for decoder: ReadableBinaryStream, path: [CodingKey]) {
            self.stream = decoder
            self.codingPath = path
        }
    }

}



public extension UnkeyedDecodingContainer {
    mutating func decodeArray<T, C>(of type: T.Type, count: C) throws -> [T] where T: Decodable, C: FixedWidthInteger {
        var result: [T] = []
        result.reserveCapacity(Int(count))
        for _ in 0..<count {
            result.append(try decode(T.self))
        }
        return result
    }
}
