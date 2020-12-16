//
//  String+Localizable.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
