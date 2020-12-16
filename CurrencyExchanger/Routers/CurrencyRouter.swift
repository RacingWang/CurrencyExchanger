//
//  CurrencyRouter.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import Alamofire

enum CurrencyRouter: Routable {
    case list
    case live

    var method: HTTPMethod {
        switch self {
        case .list, .live:
            return .get
        }
    }
    var path: String {
        switch self {
        case .list:
            return "list"
        case .live:
            return "live"
        }
    }
    
    func encodeParameters(into request: URLRequest) throws -> URLRequest {
        switch self {
        case .list, .live:
            return request
        }
    }
}
