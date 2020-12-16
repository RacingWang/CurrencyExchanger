//
//  Preference.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import Alamofire

final class Preference {
    typealias Completion = () -> Void
    
    @Storage(key: "supported_currencies", defaultValue: [])
    static var supportedCurrencies: [Currency]

    class func reload(completion: Completion? = nil) {
        AF.request(CurrencyRouter.list)
            .validate()
            .responseDecodable(of: ListResponse.self) { response in
                switch response.result {
                case let .success(resp):
                    self.supportedCurrencies = resp.currencies
                case let .failure(error):
                    print("error: \(error)")
                }
                completion?()
        }
    }
}
