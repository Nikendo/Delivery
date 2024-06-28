//
//  MockUserSessionManager.swift
//  UserSessionManagerTests
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import Delivery


final class MockUserSessionManager: UserSessionManagerProtocol {
    private(set) var isAuthorized: ObservableValue<Bool> = .init(value: false)

    private var userSession: UserSession?

    init() {
        self.isAuthorized.value = loadSession() != nil
    }

    func saveSession(userID: String, accessToken: String, refreshToken: String?, userInfo: UserInfo) {
        userSession = UserSession(
            userID: userID,
            accessToken: accessToken,
            refreshToken: refreshToken,
            userInfo: userInfo
        )
        isAuthorized.value = loadSession() != nil
    }
    
    func loadSession() -> UserSession? {
        userSession
    }
    
    func clearSession() {
        userSession = nil
    }
}
