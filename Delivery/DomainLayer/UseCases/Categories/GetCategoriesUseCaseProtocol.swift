//
//  GetCategoriesUseCaseProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import Foundation


public protocol GetCategoriesUseCaseProtocol: AnyObject {
    func execute() async throws -> [Category]
}
