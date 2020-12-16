//
//  RegisterCell.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import UIKit

extension UITableView {

    func register(cellClass: UITableViewCell.Type) {
         register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
     }

     func register(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
         register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterViewClass.self))
     }

    func registerCellNib(cellClass: UITableViewCell.Type) {
        let identifier = String(describing: cellClass.self)
         register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
     }

     func registerHeaderFooterNib(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        let identifier = String(describing: headerFooterViewClass.self)
         register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
     }
}

extension UICollectionView {

    func register(cellClass: UICollectionViewCell.Type) {
        register(cellClass,forCellWithReuseIdentifier: String(describing: cellClass.self))
    }

    func register(headerClass: UICollectionReusableView.Type) {
        register(headerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: headerClass.self))
    }

    func register(footerClass: UICollectionReusableView.Type) {
        register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: footerClass.self))
    }

    func registerCellNib(cellClass: UICollectionViewCell.Type) {
        let identifier = String(describing: cellClass.self)
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }

    func registerHeaderNib(reusableViewClass: UICollectionReusableView.Type) {
        let identifier = String(describing: reusableViewClass.self)
        register(UINib(nibName: identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }

    func registerFooterNib(reusableViewClass: UICollectionReusableView.Type) {
        let identifier = String(describing: reusableViewClass.self)
        register(UINib(nibName: identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }
}
