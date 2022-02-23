// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 22/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public protocol BinaryStream {
    var codingPath: [CodingKey] { get set }
    var enableLogging: Bool { get }
    func debugKey<K>(_ value: Any, key: K) where K: CodingKey
    mutating func pushPath<K>(_ key: K) where K: CodingKey
    mutating func popPath()
}

public extension BinaryStream {
    func debugKey<K: CodingKey>(_ value: Any, key: K) {
        if enableLogging {
            var path = codingPath
            path.append(key)
            print("encoding \(path.compactDescription): \(value)")
        }
    }
    
    mutating func pushPath<K>(_ key: K) where K : CodingKey {
        codingPath = codingPath + [key]
    }
    
    mutating func popPath() {
        codingPath = codingPath.dropLast()
    }
}
