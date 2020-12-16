//
//  Routable.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import Alamofire

protocol Routable: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameterEncoder: ParameterEncoder { get }
    
    func encodeParameters(into request: URLRequest) throws -> URLRequest
}

extension Routable {
    var baseURL: URL {
        URL(string: "http://api.currencylayer.com")!
    }
    var headers: HTTPHeaders {
        let headers: HTTPHeaders = []
        return headers
    }
    var parameterEncoder: ParameterEncoder {
        switch method {
        case .get, .head, .delete:
            return URLEncodedFormParameterEncoder()
        default:
            return JSONParameterEncoder()
        }
    }
    private var accessKey: String {
        "12a01fb61a4e6059ee8ce75ab953a35c"
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        let request = try URLEncodedFormParameterEncoder().encode(["access_key": accessKey],
                                                                        into: URLRequest(url: url)+
                                                                            .method(method)
                                                                            .headers(headers)-)
        return try encodeParameters(into: request)
    }
    
    func encodeParameters(into request: URLRequest) throws -> URLRequest {
        request
    }

}
