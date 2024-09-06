//
//  LoginUseCaseProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Foundation


public protocol LoginUseCaseProtocol: AnyObject {
    func execute(email: String, password: String) async throws
}
