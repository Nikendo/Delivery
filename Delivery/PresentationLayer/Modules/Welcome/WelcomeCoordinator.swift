//
//  WelcomeCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class WelcomeCoordinator: Coordinator {
    public var navigationController: UINavigationController

    private let userSessionManager: UserSessionManagerProtocol

    init(navigationController: UINavigationController, userSessionManager: UserSessionManagerProtocol) {
        self.navigationController = navigationController
        self.userSessionManager = userSessionManager
    }

    public func start() {
        let loginUseCase: LoginUseCaseProtocol = LoginUseCase(authService: FirebaseAuthService(), userSessionManager: userSessionManager)
        let viewModel: WelcomeViewModelProtocol = WelcomeViewModel(coordinator: self, loginUseCase: loginUseCase)
        let viewController = WelcomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
