//
//  HomeViewController.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()+
            .borderStyle(.roundedRect)
            .textAlignment(.right)
            .keyboardType(.decimalPad)
            .text(viewModel.amountText)-
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        return textField
    }()
    private lazy var currencyTextField: UITextField = {
        let picker = UIPickerView()+
            .backgroundColor(UIColor.white)
            .dataSource(self)
            .delegate(self)-
        let textField = UITextField()+
            .textAlignment(.right)
            .borderStyle(.roundedRect)
            .text(viewModel.selectedCurrencyText)-
        textField.bind(pickerView: picker) { [unowned self] index in
            guard index >= 0 else { return }
            self.viewModel.selectCurrency(atRow: index)
        }
        return textField
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()+
            .minimumInteritemSpacing(8)
            .minimumLineSpacing(8)
            .itemSize(CGSize(width: 100, height: 100))-
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)+
            .showsVerticalScrollIndicator(false)
            .showsHorizontalScrollIndicator(false)
            .backgroundColor(.clear)
            .dataSource(self)-
        collectionView.register(cellClass: QuoteCell.self)
        return collectionView
    }()
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUIComponents()
        setupUIAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(true,
                                                     animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false,
                                                     animated: animated)
    }
    
    private func setupUIComponents() {
        view.addSubview(amountTextField)
        amountTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(24)
        }
        
        view.addSubview(currencyTextField)
        currencyTextField.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.width.equalTo(150)
            make.height.equalTo(24)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.top.equalTo(currencyTextField.snp.bottom).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(onTapScreen))+
            .cancelsTouchesInView(false)-
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUIAttributes() {
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @objc
    private func onTapScreen() {
        view.endEditing(true)
    }
    
    @objc
    private func textFieldDidChange() {
        guard let amount = amountTextField.text else { return }
        viewModel.update(amount: amount)
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfQuotes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = viewModel[indexPath.item]
        let cell: QuoteCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(vm)
        return cell
    }
}

extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfCurrencies
    }
}

extension HomeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return viewModel.currency(forRow: row)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func homeViewModelDidUpdate(_ viewModel: HomeViewModelProtocol) {
        amountTextField.text = viewModel.amountText
        currencyTextField.text = viewModel.selectedCurrencyText
        collectionView.reloadData()
    }
}
