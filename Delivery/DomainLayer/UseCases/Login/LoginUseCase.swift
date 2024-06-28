//
//  LoginUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Foundation


public protocol LoginUseCaseProtocol: AnyObject {
    func execute(email: String, password: String) async throws
}

public final class LoginUseCase: LoginUseCaseProtocol {
    private let authService: AuthServiceProtocol
    private let userSessionManager: UserSessionManagerProtocol

    public init(authService: AuthServiceProtocol, userSessionManager: UserSessionManagerProtocol) {
        self.authService = authService
        self.userSessionManager = userSessionManager
    }

    public func execute(email: String, password: String) async throws {
        let user = try await authService.signIn(email: email, password: password)
        userSessionManager.saveSession(
            userID: user.userID,
            accessToken: user.accessToken,
            refreshToken: user.refreshToken,
            userInfo: user.userInfo
        )
    }
}
