//
//  AuthServiceProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Foundation


public protocol AuthServiceProtocol: AnyObject {
    func signIn(email: String, password: String) async throws -> UserSession
}
