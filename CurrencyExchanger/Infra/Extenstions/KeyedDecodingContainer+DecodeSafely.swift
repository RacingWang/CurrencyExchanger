//
//  KeyedDecodingContainer+DecodeSafely.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeSafely<T: Decodable>(_ key: Self.Key) -> T? {
        do {
            return try decodeIfPresent(T.self, forKey: key)
        } catch {
            print("decoding error: \(error)")
            return nil
        }
    }
}
