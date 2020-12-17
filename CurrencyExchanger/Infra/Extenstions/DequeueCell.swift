//
//  DequeueCell.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    func dequeueReusableHeaderFooterView<T>() -> T where T: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}

extension UICollectionView {
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    func dequeueReusableSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    func dequeueReusableHeaderView<T>(for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    func dequeueReusableFooterView<T>(for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionFooter
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
