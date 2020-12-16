//
//  HomeViewModel.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import Alamofire

protocol HomeViewModelDelegate: AnyObject {
    func homeViewModelDidUpdate(_ viewModel: HomeViewModelProtocol)
}

protocol HomeViewModelProtocol {
    subscript(_ index: Int) -> QuoteCellViewModel { get }

    var delegate: HomeViewModelDelegate? { get set }
    var numberOfCurrencies: Int { get }
    var numberOfQuotes: Int { get }

    func currencyCode(forRow row: Int) -> String
    func selectCurrency(atRow row: Int) -> String
    func update(amount: String)
    func fetchQuotes()
}

final class HomeViewModel: HomeViewModelProtocol {
    subscript(index: Int) -> QuoteCellViewModel {
        let quote = quotes[index]
        return QuoteCellViewModel(quote: quote, amount: amount)
    }
    weak var delegate: HomeViewModelDelegate?
    var numberOfCurrencies: Int {
        currencies.count
    }
    var numberOfQuotes: Int {
        quotes.count
    }
    private var amount: Double = 0 {
        didSet {
            delegate?.homeViewModelDidUpdate(self)
        }
    }
    private var currentCurrencyCode: String? {
        didSet {
            fetchQuotes()
        }
    }
    private var currencies: [Currency] {
        Preference.supportedCurrencies
    }
    private var quotes = [Quote]() {
        didSet {
            delegate?.homeViewModelDidUpdate(self)
        }
    }
    private var fetchingRequest: DataRequest?
    private let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func currencyCode(forRow row: Int) -> String {
        currencies[row].code
    }
    
    func selectCurrency(atRow row: Int) -> String {
        let currencyCode = self.currencyCode(forRow: row)
        currentCurrencyCode = currencyCode
        return currencyCode
    }
    
    func update(amount: String) {
        guard let amount = Double(amount) else { return }
        self.amount = amount
    }
    
    func fetchQuotes() {
        guard let currentCurrencyCode = currentCurrencyCode else { return }
        
        if let fetchingRequest = fetchingRequest {
            fetchingRequest.cancel()
        }
        
        fetchingRequest = AF.request(CurrencyRouter.live(source: "USD"))
            .validate()
            .responseDecodable(of: LiveResponse.self, completionHandler: { response in
                switch response.result {
                case let .success(resp):
                    self.quotes = resp.quotes
                case let .failure(error):
                    print("error: \(error)")
                }
        })
    }
}

struct QuoteCellViewModel {
    var currency: String
    var rate: String
    var amount: String
    
    init(quote: Quote,
         amount: Double) {
        self.currency = quote.code
        self.rate = "\(quote.rate)"
        self.amount = "\(quote.rate * amount)"
    }
    
}
