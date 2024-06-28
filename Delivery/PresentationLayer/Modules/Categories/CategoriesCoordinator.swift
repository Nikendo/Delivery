//
//  CategoriesCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class CategoriesCoordinator: Coordinator {
    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewController = CategoriesViewController()
        viewController.title = TabBarItems.categories.title
        navigationController.setViewControllers([viewController], animated: true)
    }
}
