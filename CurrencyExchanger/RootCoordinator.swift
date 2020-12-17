//
//  RootCoordinator.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import UIKit

protocol RootCoordinatorProtocol {
    var homeScene: UIViewController { get }
}

final class RootCoordinator: RootCoordinatorProtocol {
    
    var homeScene: UIViewController {
        let coordinator = HomeCoordinator()
        let viewModel = HomeViewModel(coordinator: coordinator)
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        coordinator.navigator = navigationController
        viewModel.delegate = viewController
        
        return navigationController
    }

}
