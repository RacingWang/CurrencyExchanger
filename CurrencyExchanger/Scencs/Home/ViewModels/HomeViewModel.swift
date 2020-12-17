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
    var amountText: String? { get }
    var selectedCurrencyText: String? { get }
    var numberOfCurrencies: Int { get }
    var numberOfQuotes: Int { get }

    func currency(forRow row: Int) -> String
    func selectCurrency(atRow row: Int)
    func update(amount: String)
}

final class HomeViewModel: HomeViewModelProtocol {
    subscript(index: Int) -> QuoteCellViewModel {
        let quote = quotes[index]
        return QuoteCellViewModel(quote: quote, amount: amount)
    }
    
    weak var delegate: HomeViewModelDelegate?
    var amountText: String? {
        "\(amount)"
    }
    var selectedCurrencyText: String? {
        selectedCurrency?.code ?? "-"
    }
    var numberOfCurrencies: Int {
        currencies.count
    }
    var numberOfQuotes: Int {
        quotes.count
    }
    private lazy var currencyService: CurrencyServiceProtocol = {
        let service = CurrencyService()+
            .delegate(self)-
        return service
    }()
    private var amount: Double = 0 {
        didSet {
            delegate?.homeViewModelDidUpdate(self)
        }
    }
    private var selectedCurrency: Currency? {
        willSet {
            if let currency = newValue {
                quotes = currencyService.getQuotes(byCurrency: currency)
            } else {
                quotes = [Quote]()
            }
        }
        didSet {
            delegate?.homeViewModelDidUpdate(self)
        }
    }
    private var currencies: [Currency] {
        currencyService.supportedCurrencies
    }
    private var quotes = [Quote]()
    private let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
        
        currencyService.activate()
    }
    
    func currency(forRow row: Int) -> String {
        currencies[row].code
    }
    
    func selectCurrency(atRow row: Int) {
        let currency = currencies[row]
        selectedCurrency = currency
    }
    
    func update(amount: String) {
        guard let amount = Double(amount) else { return }
        self.amount = amount
    }
}

extension HomeViewModel: CurrencyServiceDelegate {
    func currencyServiceDidUpdate(_ service: CurrencyServiceProtocol) {
        selectedCurrency = service.supportedCurrencies.first
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
        self.amount = "\((quote.rate * amount * 100).rounded() / 100)"
    }
}
