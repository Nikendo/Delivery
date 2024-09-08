//
//  UserSessionManagerProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.06.2024.
//

import Foundation
import DomainLayer


public protocol UserSessionManagerProtocol: AnyObject {
    var isAuthorized: ObservableValue<Bool> { get }
    
    func saveSession(userID: String, accessToken: String, refreshToken: String?, userInfo: UserInfo)
    func loadSession() -> UserSession?
    func clearSession()
}
