// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

public protocol StringDecodingPolicy {
    func decodeString(with decoder: BinaryDecoder) throws -> String
}

public struct ZeroTerminatedStringDecodingPolicy: StringDecodingPolicy {
    let encoding: String.Encoding
    
    public func decodeString(with decoder: BinaryDecoder) throws -> String {
        var bytes: [UInt8] = []
        while let byte = try? decoder.decode(UInt8.self), byte != 0 {
            bytes.append(byte)
        }
        
        guard let string = String(bytes: bytes, encoding: encoding) else {
            throw BinaryCodingError.badStringEncoding
        }
        
        return string
    }
}

public struct LengthStringDecodingPolicy: StringDecodingPolicy {
    let encoding: String.Encoding
    
    public func decodeString(with decoder: BinaryDecoder) throws -> String {
        let length = try decoder.decode(UInt32.self)
        let data = try decoder.decodeArray(of: UInt8.self, count: Int(length))
        guard let string = String(bytes: data, encoding: encoding) else {
            throw BinaryCodingError.badStringEncoding
        }
        
        return string
    }
}

public protocol BinaryDecoder: Decoder {
    var stringDecodingPolicy: StringDecodingPolicy { get }
    var enableLogging: Bool { get }
    func decode<T: Decodable>(_ type: T.Type) throws -> T
}

public extension BinaryDecoder {
    func decodeArray<T: Decodable>(of type: T.Type, count: Int) throws -> [T] {
        var results: [T] = []
        results.reserveCapacity(count)
        for _ in 0..<count {
            results.append(try decode(type))
        }
        return results
    }
}

public protocol BinaryDecodable: Decodable {
    init(fromBinary decoder: BinaryDecoder) throws
}

public extension BinaryDecodable {
    init(fromBinary decoder: BinaryDecoder) throws {
        if decoder.enableLogging {
            print("fallback binary decoding for \(Self.self)")
        }
        
        try self.init(from: decoder)
    }
}
