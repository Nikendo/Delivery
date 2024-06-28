//
//  FirebaseAuthService.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import FirebaseAuth


public class FirebaseAuthService: AuthServiceProtocol {
    public func signIn(email: String, password: String) async throws -> UserSession {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = result.user
        let accessToken = try await user.getIDToken()
        guard
            let email = user.email
        else {
            throw LoginError.parsingError
        }

        let userInfo = UserInfo(email: email, name: user.displayName ?? "", avatarURL: user.photoURL)

        return UserSession(userID: user.uid, accessToken: accessToken, refreshToken: user.refreshToken, userInfo: userInfo)
    }
}
