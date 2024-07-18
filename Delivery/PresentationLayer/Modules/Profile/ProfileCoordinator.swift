//
//  ProfileCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class ProfileCoordinator: Coordinator {
    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewController = ProfileViewController()
        viewController.title = TabBarItems.profile.title
        navigationController.setViewControllers([viewController], animated: true)
    }
}
