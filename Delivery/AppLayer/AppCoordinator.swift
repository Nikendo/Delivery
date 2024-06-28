//
//  AppCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public class AppCoordinator: Coordinator {
    public var navigationController: UINavigationController
    
    private var authorized: Bool

    public init(navigationController: UINavigationController, authorized: Bool) {
        self.navigationController = navigationController
        self.authorized = authorized
    }

    public func start() {
        guard authorized else {
            showLogin()
            return
        }
        showMainTabBar()
    }

    private func showMainTabBar() {
        let tabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
    }

    private func showLogin() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController)
        welcomeCoordinator.start()
    }
}
