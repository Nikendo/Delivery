//
//  WelcomeCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit
import DataLayer
import DomainLayer


public final class WelcomeCoordinator: Coordinator {
    public var navigationController: UINavigationController

    private let userSessionManager: UserSessionManagerProtocol

    public init(navigationController: UINavigationController, userSessionManager: UserSessionManagerProtocol) {
        self.navigationController = navigationController
        self.userSessionManager = userSessionManager
    }

    public func start() {
        let loginUseCase: LoginUseCaseProtocol = LoginUseCase(authRepository: FirebaseAuthRepository(userSessionManager: userSessionManager))
        let viewModel: WelcomeViewModelProtocol = WelcomeViewModel(coordinator: self, loginUseCase: loginUseCase)
        let viewController = WelcomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
