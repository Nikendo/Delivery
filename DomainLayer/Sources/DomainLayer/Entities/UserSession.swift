//
//  UserSession.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import Foundation


public struct UserSession {
    public let userID: String
    public let accessToken: String
    public let refreshToken: String?
    public let userInfo: UserInfo

    public init(userID: String, accessToken: String, refreshToken: String?, userInfo: UserInfo) {
        self.userID = userID
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.userInfo = userInfo
    }
}
