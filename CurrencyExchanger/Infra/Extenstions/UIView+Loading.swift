//
//  UIView+Loading.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    struct AssociatedKeys {
        static var loadingView = "loadingView"
    }
    
    enum LoadingType {
        case clear
        case dim
        case hud
    }
    
    func startLoading(type: LoadingType = .hud) {
        let contentView = UIView()+
            .alpha(0)-
        switch type {
        case .clear:
            contentView.backgroundColor = .clear
        case .dim, .hud:
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            switch type {
            case .clear, .dim:
                make.edges.equalToSuperview()
            case .hud:
                make.width.height.equalTo(50)
                make.center.equalToSuperview()
            }
        }
        contentView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.center.equalToSuperview()
        }
        loadingView.startAnimating()
        UIView.animate(withDuration: 0.25) {
            contentView.alpha = 1
        }
    }
    
    func stopLoading() {
        UIView.animate(withDuration: 0.25, animations: {
            self.loadingView.superview?.alpha = 0
        }) { success in
            self.loadingView.stopAnimating()
            self.loadingView.superview?.removeFromSuperview()
            self.loadingView.removeFromSuperview()
        }
    }
    
    private var loadingView: UIImageView {
        get {
            if let loadingView = objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIImageView {
                return loadingView
            }
            
            let animationImages: [UIImage] = (1...6).map{ UIImage(named: "loadingPage\($0)")! }
            let loadingView = UIImageView()+
                .animationDuration(0.3)
                .animationImages(animationImages)-
            objc_setAssociatedObject(self, &AssociatedKeys.loadingView, loadingView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return loadingView
        }
    }
    
}
