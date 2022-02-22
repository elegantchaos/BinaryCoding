// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public class DataEncoder: BinaryEncoder, WriteableBinaryStream {
    public var codingPath: [CodingKey]
    public var userInfo: [CodingUserInfoKey : Any]
    var data: Data
    public var stringEncoding: String.Encoding

    public init() {
        self.codingPath = []
        self.userInfo = [:]
        self.data = Data()
        self.stringEncoding = .utf8
    }
    
    func encode<T: Encodable>(_ value: T) throws -> Data {
        data.removeAll()
        try writeEncodable(value)
        return data
    }
    
    func writeInt<Value>(_ value: Value) where Value: FixedWidthInteger {
        data.append(contentsOf: value.littleEndianBytes)
    }
    
    func write<Value>(_ value: Value) throws where Value: BinaryFloatingPoint {
        data.append(contentsOf: value.littleEndianBytes)
    }
    
    func write(_ value: Bool) throws {
        self.writeInt(UInt8(value ? 1 : 0))
    }

    func writeData(_ data: Data) {
        self.data.append(contentsOf: data)
    }
    
    func writeEncodable(_ value: String) throws {
        try writeString(value)
    }
    
    func writeEncodable<Value>(_ value: Value) throws where Value: Encodable {
        if let string = value as? String {
            try writeString(string)
        } else if let binary = value as? BinaryEncodable {
            try binary.binaryEncode(to: self)
        } else {
            try value.encode(to: self)
        }
    }
    
    func pushPath<K>(_ key: K) where K : CodingKey {
        codingPath.append(key)
    }
    
    func popPath() {
        codingPath.removeLast()
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        return KeyedEncodingContainer(KeyedContainer(for: self, path: codingPath))
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        return UnkeyedContainer(for: self)
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        return SingleValueContainer(for: self, path: codingPath)
    }
    
    struct UnkeyedContainer: UnkeyedEncodingContainer, WriteableBinaryStreamEncodingAdaptor {
        var codingPath: [CodingKey]
        var stream: WriteableBinaryStream
        var count: Int
        
        init(for encoder: WriteableBinaryStream) {
            self.stream = encoder
            self.codingPath = []
            self.count = 0
        }
    }
    
    struct SingleValueContainer: SingleValueEncodingContainer, WriteableBinaryStreamEncodingAdaptor {
        var codingPath: [CodingKey]
        var stream: WriteableBinaryStream
        
        init(for encoder: WriteableBinaryStream, path codingPath: [CodingKey]) {
            self.stream = encoder
            self.codingPath = codingPath
        }
    }
    
    struct KeyedContainer<K>: KeyedEncodingContainerProtocol where K: CodingKey {
        typealias Key = K

        var codingPath: [CodingKey]
        var stream: WriteableBinaryStream
        
        init(for stream: WriteableBinaryStream, path codingPath: [CodingKey]) {
            self.stream = stream
            self.codingPath = codingPath
        }
        
        func debugKey(_ value: Any, key: K) {
            print("encoding \(key.stringValue): \(value) to \(codingPath)")
        }

        mutating func encodeNil(forKey key: K) throws {
            fatalError("to do")
        }
        
        mutating func encode(_ value: Bool, forKey key: K) throws {
            debugKey(value, key: key)
            try stream.write(value)
        }
        
        mutating func encode(_ value: String, forKey key: K) throws {
            debugKey(value, key: key)
            try stream.writeString(value)
        }
        
        mutating func encode(_ value: Double, forKey key: K) throws {
            debugKey(value, key: key)
            try stream.write(value)
        }
        
        mutating func encode(_ value: Float, forKey key: K) throws {
            debugKey(value, key: key)
            try stream.write(value)
        }
        
        mutating func encode(_ value: Int, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: Int8, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: Int16, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: Int32, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: Int64, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: UInt, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: UInt8, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: UInt16, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: UInt32, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode(_ value: UInt64, forKey key: K) throws {
            debugKey(value, key: key)
            stream.writeInt(value)
        }
        
        mutating func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
            debugKey(value, key: key)
            stream.pushPath(key)
            try stream.writeEncodable(value)
            stream.popPath()
        }
        
        mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
            fatalError("to do")
        }
        
        mutating func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
            fatalError("to do")
        }
        
        mutating func superEncoder() -> Encoder {
            fatalError("to do")
        }
        
        mutating func superEncoder(forKey key: K) -> Encoder {
            fatalError("to do")
        }
        
        
        
    }
}
