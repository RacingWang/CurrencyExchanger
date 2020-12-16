//
//  QuoteCell.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import UIKit
import SnapKit

class QuoteCell: UICollectionViewCell {
    
    private let currencyLabel: UILabel = {
        let label = UILabel()+
            .font(.boldSystemFont(ofSize: 14))
            .minimumScaleFactor(0.5)-
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()+
            .font(.systemFont(ofSize: 12))
            .minimumScaleFactor(0.5)-
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()+
            .font(.systemFont(ofSize: 12))
            .minimumScaleFactor(0.5)-
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUIComponents()
        setupUIAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: QuoteCellViewModel) {
        currencyLabel.text = viewModel.currency
        rateLabel.text = viewModel.rate
        amountLabel.text = viewModel.amount
    }
    
    private func setupUIComponents() {
        let stackView = UIStackView()+
            .axis(.vertical)
            .distribution(.fillEqually)-
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(4)
        }
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(rateLabel)
        stackView.addArrangedSubview(amountLabel)
    }
    
    private func setupUIAttributes() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 5
    }
    
}
