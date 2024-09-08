//
//  UserSessionManager.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import Foundation
import KeychainAccess
import Combine
import DomainLayer


public final class UserSessionManager: UserSessionManagerProtocol {
    private let keychain: Keychain = Keychain(service: "com.nikendo.app.Delivery")
    private let userDefaults: UserDefaults = UserDefaults.standard

    private(set) public var isAuthorized: ObservableValue<Bool> = .init(value: false)

    private enum Keys {
        static let userID = "userID"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let email = "email"
        static let name = "name"
        static let avatarURL = "avatarURL"
    }

    public init() {
        isAuthorized.value = loadSession() != nil
    }

    public func saveSession(userID: String, accessToken: String, refreshToken: String?, userInfo: UserInfo) {
        keychain[Keys.userID] = userID
        keychain[Keys.accessToken] = accessToken

        if let refreshToken {
            keychain[Keys.refreshToken] = refreshToken
        }

        userDefaults.set(userInfo.email, forKey: Keys.email)
        userDefaults.set(userInfo.name, forKey: Keys.name)

        if let avatarURL = userInfo.avatarURL {
            userDefaults.set(avatarURL, forKey: Keys.avatarURL)
        }

        // Need to improve a logic.
        // Think about an expiration date.
        isAuthorized.value = loadSession() != nil
    }
    
    public func loadSession() -> UserSession? {
        guard
            let userID = keychain[Keys.userID],
            let accessToken = keychain[Keys.accessToken]
        else { return nil }

        let refreshToken: String? = keychain[Keys.refreshToken]

        let email: String = userDefaults.string(forKey: Keys.email) ?? ""
        let name: String = userDefaults.string(forKey: Keys.name) ?? ""
        let avatarURL: URL? = userDefaults.url(forKey: Keys.avatarURL)

        let userInfo: UserInfo = UserInfo(email: email, name: name, avatarURL: avatarURL)

        return UserSession(userID: userID, accessToken: accessToken, refreshToken: refreshToken, userInfo: userInfo)
    }
    
    public func clearSession() {
        keychain[Keys.userID] = nil
        keychain[Keys.accessToken] = nil
        keychain[Keys.refreshToken] = nil
        userDefaults.removeObject(forKey: Keys.email)
        userDefaults.removeObject(forKey: Keys.name)
        userDefaults.removeObject(forKey: Keys.avatarURL)
    }
}
