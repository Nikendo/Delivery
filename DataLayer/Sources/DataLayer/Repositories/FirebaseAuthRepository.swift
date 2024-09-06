//
//  FirebaseAuthRepository.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import FirebaseAuth
import DomainLayer


public class FirebaseAuthRepository: AuthRepository {
    private let userSessionManager: UserSessionManagerProtocol
    
    public init(userSessionManager: UserSessionManagerProtocol) {
        self.userSessionManager = userSessionManager
    }
    
    public func signIn(email: String, password: String) async throws -> UserSession {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = result.user
        let accessToken = try await user.getIDToken()
        guard let email = user.email else { throw NetworkError.decodingError }

        let userInfo = UserInfo(email: email, name: user.displayName ?? "", avatarURL: user.photoURL)
        let userSession = UserSession(userID: user.uid, accessToken: accessToken, refreshToken: user.refreshToken, userInfo: userInfo)
        
        userSessionManager.saveSession(
            userID: userSession.userID,
            accessToken: userSession.accessToken,
            refreshToken: userSession.refreshToken,
            userInfo: userSession.userInfo
        )
        
        return userSession
    }
    
    public func signUp(email: String, password: String) async throws -> UserSession {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = result.user
        let accessToken = try await user.getIDToken()
        
        guard let email = user.email else { throw NetworkError.decodingError }

        let userInfo = UserInfo(email: email, name: user.displayName ?? "", avatarURL: user.photoURL)
        let userSession = UserSession(userID: user.uid, accessToken: accessToken, refreshToken: user.refreshToken, userInfo: userInfo)
        
        userSessionManager.saveSession(
            userID: userSession.userID,
            accessToken: userSession.accessToken,
            refreshToken: userSession.refreshToken,
            userInfo: userSession.userInfo
        )
        
        return userSession
    }
}
