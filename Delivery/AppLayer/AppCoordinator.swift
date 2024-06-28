//
//  AppCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit
import Combine


public class AppCoordinator: Coordinator {
    public var navigationController: UINavigationController
    
    private let userSessionManager: UserSessionManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    public init(navigationController: UINavigationController, userSessionManager: UserSessionManagerProtocol) {
        self.navigationController = navigationController
        self.userSessionManager = userSessionManager
        bind()
    }

    public func start() {
        guard userSessionManager.isAuthorized.value else {
            showLogin()
            return
        }
        showMainTabBar()
    }

    private func bind() {
        userSessionManager.isAuthorized.$value
            .receive(on: RunLoop.main)
            .sink { [weak self] isAuthorized in
                guard isAuthorized else {
                    self?.showLogin()
                    return
                }
                self?.showMainTabBar()
            }
            .store(in: &cancellables)
    }

    private func showMainTabBar() {
        let tabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
    }

    private func showLogin() {
        let welcomeCoordinator = WelcomeCoordinator(navigationController: navigationController, userSessionManager: userSessionManager)
        welcomeCoordinator.start()
    }
}
