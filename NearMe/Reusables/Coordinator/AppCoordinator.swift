//
//  AppCoordinator.swift
//  NearMe
//
//  Created by Serhat Sezer on 19.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private var dependenciesContainer: Container
    
    required init(_ window: UIWindow,
                  dependenciesContainer: Container,
                  navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.dependenciesContainer = dependenciesContainer
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let homeVM = dependenciesContainer.resolve(HomeViewModelProtocol.self)!
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController,
                                              viewModel: homeVM)
        homeCoordinator.start()
       
    }
}
