//
//  GetProductsUseCaseProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation


public protocol GetProductsUseCaseProtocol: AnyObject {
    func execute() async throws -> [Product]
}
