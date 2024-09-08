//
//  AuthRepository.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Foundation


public protocol AuthRepository: AnyObject {
    func signIn(email: String, password: String) async throws -> UserSession
    func signUp(email: String, password: String) async throws -> UserSession
}
