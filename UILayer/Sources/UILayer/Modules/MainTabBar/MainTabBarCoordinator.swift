//
//  MainTabBarCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class MainTabBarCoordinator: Coordinator {
    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let tabControllers: [UIViewController] = TabBarItems.allCases.map { tab in
            let navController = UINavigationController()
            let coordinator: Coordinator = switch tab {
            case .categories: CategoriesCoordinator(navigationController: navController)
            case .cart: CartCoordinator(navigationController: navController)
            case .profile: ProfileCoordinator(navigationController: navController)
            }
            coordinator.start()

            navController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.image,
                selectedImage: tab.selectedImage
            )
            return navController
        }

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(resource: .A_259_FF)
        tabBarController.setViewControllers(tabControllers, animated: true)
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
