// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 22/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Bytes
import Foundation

//class ReadableBuffer: ReadableBinaryStream {
//    var data: Bytes
//    var index: Bytes.Index
//
//    public init(bytes: Bytes) {
//        self.data = bytes
//        self.index = bytes.startIndex
//    }
//
//    public func read(_ count: Int) throws -> ArraySlice<Byte> {
//        let end = index.advanced(by: count)
//        guard end <= data.endIndex else { throw BinaryCodingError.outOfData }
//
//        let slice = data[index..<end]
//        index = end
//        return slice
//    }
//
//    public func read(until: Byte)  throws -> ArraySlice<Byte> {
//        
//        guard let end = data[index...].firstIndex(of: until) else { throw BinaryCodingError.outOfData }
//        let slice = data[index..<end]
//        index = data.index(end, offsetBy: 1)
//        return slice
//    }
//
//    public func readInt<T>(_ type: T.Type) throws -> T where T: FixedWidthInteger {
//        let bytes = try read(MemoryLayout<T>.size)
//        return try T(littleEndianBytes: bytes)
//    }
//
//    public func readFloat<T>(_ type: T.Type) throws -> T where T: BinaryFloatingPoint {
//        let bytes = try read(MemoryLayout<T>.size)
//        return try T(littleEndianBytes: bytes)
//    }
//    
//    public func readAll() -> ArraySlice<Byte> {
//        return data[index...]
//    }
//    
//    public func remainingCount() -> Int {
//        data.count - index
//    }
//  
//}
