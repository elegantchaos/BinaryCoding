// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 14/02/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

// TODO: Change EnumForOptionSet to not require RawRepresentable where RawValue == String.
//       Add explicit interface to EnumForOptionSet to do the conversion to/from strings
//       and to/from flag/mask values.
//       OptionSetFromEnum should still encode/decode them as lists of strings, but should
//       do so explicitly using the to/from string interface on EnumForOptionSet.

public protocol EnumForOptionSet: Codable, CaseIterable, Equatable, RawRepresentable where RawValue == String {
}

public protocol OptionSetFromEnum: OptionSet, BinaryCodable, CustomStringConvertible where Options.AllCases.Index: FixedWidthInteger, RawValue: FixedWidthInteger, RawValue: BinaryCodable {
    associatedtype Options: EnumForOptionSet
    init(arrayLiteral elements: Options...)
    init(from decoder: Decoder) throws
    init(knownRawValue: RawValue)
}

// TODO: add support for encoding/decoding as a single string when only one flag is present

public extension OptionSetFromEnum {
    init(arrayLiteral elements: Options...) {
        var value: RawValue = 0
        let cases = Options.allCases
        for node in elements {
            if let index = cases.firstIndex(of: node) {
                value = value | (1 << RawValue(index))
            }
        }

        self.init(knownRawValue: value)
    }

    init(knownRawValue: RawValue) {
        self.init(rawValue: knownRawValue)!
    }
    
    init(from decoder: Decoder) throws {
        let cases = Options.allCases
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(RawValue.self) {
            self.init(knownRawValue: value)
        } else {
            var container = try decoder.unkeyedContainer()
            var value: RawValue = 0
            while let node = try? container.decode(Options.self), let index = cases.firstIndex(of: node) {
                value = value | (1 << index)
            }
            self.init(knownRawValue: value)
        }
    }

    func encode(to encoder: Encoder) throws {
        var index = RawValue(1)

        var container = encoder.unkeyedContainer()
        for flag in Options.allCases {
            if (rawValue & index) != 0 {
                try container.encode(flag)
            }
            index = index << 1
        }
    }
    
    var options: [Options] {
        
        var result: [Options] = []

        var mask = RawValue(1)
        for flag in Options.allCases {
            if (rawValue & mask) != 0 {
                result.append(flag)
            }
            mask = mask << 1
        }
        return result
    }
    
    init(fromBinary decoder: BinaryDecoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(rawValue: container.decode(RawValue.self))
    }
    
    func binaryEncode(to encoder: BinaryEncoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
    
    func contains2(_ option: Options) -> Bool {
        var index = RawValue(1)
        for flag in Options.allCases {
            if flag == option {
                return (rawValue & index) != 0
            }
            index = index << 1
        }
        return false
    }
    
    var description: String {
        return self.options.map({ $0.rawValue }).joined(separator: ", ")
    }
}

extension OptionSetFromEnum {
    func contains(_ members: Set<Options>) -> Bool where Options: Hashable {
        var index = RawValue(1)
        for flag in Options.allCases {
            if members.contains(flag) {
                return (rawValue & index) != 0
            }
            index = index << 1
        }
        return false
    }
}
