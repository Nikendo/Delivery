//
//  RegistrationUseCaseProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//


public protocol RegistrationUseCaseProtocol: AnyObject {
    func execute(email: String, password: String) async throws
}
