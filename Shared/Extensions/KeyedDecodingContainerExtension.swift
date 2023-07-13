//
//  KeyedDecodingContainerExtension.swift
//  Frucht
//
//  Created by Feni Brian on 19/07/2022.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode(_ type: Measurement<UnitMass>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Measurement<UnitMass> {
        let valueString = try decode(String.self, forKey: key)
        return Measurement(string: valueString)
    }
    
    public func decode(_ type: Measurement<UnitVolume>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Measurement<UnitVolume> {
        let valueString = try decode(String.self, forKey: key)
        return Measurement(string: valueString)
    }
}

