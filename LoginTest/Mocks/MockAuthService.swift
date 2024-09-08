//
//  MockAuthService.swift
//  LoginTest
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Delivery


final class MockAuthService: AuthRepository {
    private let email: String
    private let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    func signIn(email: String, password: String) async throws -> UserSession {
        try await Task.sleep(nanoseconds: 1_000_000)
        guard email == self.email && password == self.password else {
            throw LoginError.wrongCredentials
        }

        return UserSession(
            userID: "123",
            accessToken: "123",
            refreshToken: "123",
            userInfo: UserInfo(
                email: "johndoe@gmail.com",
                name: "John",
                avatarURL: nil
            )
        )
    }
}
