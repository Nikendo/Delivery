//
//  UserInfo.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import Foundation


public struct UserInfo {
    public let email: String
    public let name: String
    public let avatarURL: URL?

    public init(email: String, name: String, avatarURL: URL?) {
        self.email = email
        self.name = name
        self.avatarURL = avatarURL
    }
}
