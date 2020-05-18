//
//  AppDelegate.swift
//  NearMe
//
//  Created by Serhat Sezer on 11.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    fileprivate var appCoordinator: AppCoordinator?
    
    // Setting up the container
    var container: Container = {
        let container = Container()
        container.register(HomeRestaurantServiceProtocol.self) { _ in
            HomeRestaurantService()
        }
        container.register(HomeRepositoryProtocol.self) { r in
            HomeRepository(service: r.resolve(HomeRestaurantServiceProtocol.self)!)
        }
        container.register(HomeViewModelProtocol.self) { r in
            HomeViewModel(repository: r.resolve(HomeRepositoryProtocol.self)!)
        }
        
        container.register(HomeViewController.self) { r in
            let viewController = HomeViewController()
            viewController.viewModel = r.resolve(HomeViewModelProtocol.self)
            return viewController
        }
        
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInitialScreen()
        return true
    }
}


/// MARK: Initialation
private extension AppDelegate {
    func setupInitialScreen() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.appCoordinator = AppCoordinator(self.window!, dependenciesContainer: container)
        self.appCoordinator?.start()
    }
}
