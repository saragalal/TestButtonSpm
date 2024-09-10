//
//  NonFailableType.swift
//  Almtaar
//
//  Created by Waleed Saad on 02/11/2023.
//  Copyright © 2023 almatar. All rights reserved.
//

import Foundation

@propertyWrapper
struct NonFailableType<T: Codable>: Codable {

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
        wrappedValue = container?.decodeNil() ?? true ? nil : try? container?.decode(T.self)
    }
}

// MARK: - KeyedDecodingContainer

extension KeyedDecodingContainer {
    
    func decode<T>(_: NonFailableType<T>.Type, forKey key: Key) throws -> NonFailableType<T> {
        try decodeIfPresent(NonFailableType<T>.self, forKey: key) ?? .init()
    }
}

// MARK: - KeyedEncodingContainer

extension KeyedEncodingContainer {
    
    mutating func encode<T>(_ value: NonFailableType<T>, forKey key: Key) throws {
        try encode(value.wrappedValue, forKey: key)
    }
}
