//
//  DomainError.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//

import Foundation


public enum DomainError: Error {
    case invalidCredentials
    case userNotFound
    case operationFailed
}
