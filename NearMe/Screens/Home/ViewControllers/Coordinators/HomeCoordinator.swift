//
//  HomeCoordinator.swift
//  NearMe
//
//  Created by Serhat Sezer on 14.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var viewModel: HomeViewModelProtocol!
    
    private lazy var homeViewController: HomeViewController = {
        let controller = HomeViewController()
        controller.viewModel = self.viewModel
        return controller
    }()
    
    required init(navigationController: UINavigationController, viewModel: HomeViewModelProtocol) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        navigationController.pushViewController(homeViewController, animated: false)
    }
}

