//
//  CurrencyResponse.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation

struct ListResponse {
    let result: Bool
    let currencies: [Currency]
}

extension ListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case result = "success"
        case currencies
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = container.decodeSafely(.result) ?? false
        let currenciesDict: [String: String] = container.decodeSafely(.currencies) ?? [:]
        currencies = currenciesDict.map{ Currency(code: $0, name: $1) }
    }
}

struct LiveResponse {
    let result: Bool
    let quotes: [String: Double]
}

extension LiveResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case result = "success"
        case quotes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = container.decodeSafely(.result) ?? false
        quotes = Dictionary(uniqueKeysWithValues: (container.decodeSafely(.quotes) ?? [String: Double]()).map{ (String($0.dropFirst(3)), $1) })
    }
}
