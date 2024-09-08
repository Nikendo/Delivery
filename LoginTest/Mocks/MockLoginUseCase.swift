//
//  MockLoginUseCase.swift
//  LoginTest
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Delivery


public final class MockLoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepository
    private let userSessionManager: UserSessionManagerProtocol

    public init(authRepository: AuthRepository, userSessionManager: UserSessionManagerProtocol) {
        self.authRepository = authRepository
        self.userSessionManager = userSessionManager
    }

    public func execute(email: String, password: String) async throws {
        let userSession: Delivery.UserSession = try await authRepository.signIn(email: email, password: password)
        userSessionManager.saveSession(
            userID: userSession.userID,
            accessToken: userSession.accessToken,
            refreshToken: userSession.refreshToken,
            userInfo: userSession.userInfo
        )
    }
}
