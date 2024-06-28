//
//  WelcomeCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class WelcomeCoordinator: Coordinator {
    public var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel: WelcomeViewModelProtocol = WelcomeViewModel(coordinator: self)
        let viewController = WelcomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
