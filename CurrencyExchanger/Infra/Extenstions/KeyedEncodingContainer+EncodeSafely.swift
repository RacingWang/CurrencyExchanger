//
//  KeyedEncodingContainer+EncodeSafely.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation

extension KeyedEncodingContainer {
    mutating func encodeSafely<T: Encodable>(_ value: T,
                                             forKey key: Self.Key) {
        do {
            try encodeIfPresent(value, forKey: key)
        } catch {
            print("encoding error: \(error)")
        }
    }
}
