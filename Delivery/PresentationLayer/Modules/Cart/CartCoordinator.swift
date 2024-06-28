//
//  CartCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class CartCoordinator: Coordinator {
    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewController = CartViewController()
        viewController.title = TabBarItems.cart.title
        navigationController.setViewControllers([viewController], animated: true)
    }
}
