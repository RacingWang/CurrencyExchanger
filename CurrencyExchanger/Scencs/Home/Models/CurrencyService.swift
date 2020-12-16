//
//  CurrencyService.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import Alamofire

protocol CurrencyServiceDelegate: AnyObject {
    func currencyServiceDidUpdate(_ service: CurrencyServiceProtocol)
}

protocol CurrencyServiceProtocol {
    var delegate: CurrencyServiceDelegate? { get set }
    var supportedCurrencies: [Currency] { get }
    
    func fetch()
    func getQuotes(byCurrency currency: Currency) -> [Quote]
}

final class CurrencyService: CurrencyServiceProtocol {
    weak var delegate: CurrencyServiceDelegate?
    private(set) var supportedCurrencies = [Currency]()
    private var quotesTable = [String: Double]()
    
    func fetch() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        AF.request(CurrencyRouter.list)
            .validate()
            .responseDecodable(of: ListResponse.self) { response in
                switch response.result {
                case let .success(resp):
                    self.supportedCurrencies = resp.currencies
                case let .failure(error):
                    print("error: \(error)")
                }
                dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        AF.request(CurrencyRouter.live)
            .validate()
            .responseDecodable(of: LiveResponse.self) { response in
                switch response.result {
                case let .success(resp):
                    self.quotesTable = resp.quotes
                case let .failure(error):
                    print("error: \(error)")
                }
                dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.currencyServiceDidUpdate(self)
        }
    }
    
    func getQuotes(byCurrency currency: Currency) -> [Quote] {
        guard let usdRate = quotesTable[currency.code] else { return [] }
        return quotesTable.map{ Quote(code: $0, rate: (1 / usdRate * $1 * 1000).rounded() / 1000) }
    }
}
