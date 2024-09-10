//
//  NumericString.swift
//  Almtaar
//
//  Created by Waleed Saad on 02/11/2023.
//  Copyright © 2023 almatar. All rights reserved.
//

import Foundation

@propertyWrapper
struct NumericString<T: Codable & LosslessStringConvertible>: Codable {

    // MARK: - Properties

    var wrappedValue: T?
    
    // MARK: - Init

    init() {
        wrappedValue = nil
    }

    init(_ wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        wrappedValue =
        if container?.decodeNil() ?? true {
            nil
        } else {
            if let sameValueType = try? container?.decode(T.self) {
                sameValueType
            } else if let stringValue = try? container?.decode(String.self),
                      let convertedNumericType = T(stringValue) {
                convertedNumericType
            } else if let integerValue = try? container?.decode(Int.self),
                      let convertedStringType = String(integerValue) as? T {
                convertedStringType
            } else if let doubleValue = try? container?.decode(Double.self),
                      let convertedStringType = String(doubleValue) as? T {
                convertedStringType
            } else {
                nil
            }
        }
    }
}

// MARK: - KeyedDecodingContainer

extension KeyedDecodingContainer {
    
    func decode<T>(_: NumericString<T>.Type, forKey key: Key) throws -> NumericString<T> {
        try decodeIfPresent(NumericString<T>.self, forKey: key) ?? .init()
    }
}

// MARK: - KeyedEncodingContainer

extension KeyedEncodingContainer {
    
    mutating func encode<T>(_ value: NumericString<T>, forKey key: Key) throws {
        try encode(value.wrappedValue, forKey: key)
    }
}
