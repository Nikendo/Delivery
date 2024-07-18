//
//  CategoriesServiceProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import Foundation


public protocol CategoriesServiceProtocol: AnyObject {
    func fetchCategories() async throws -> [Category]
}
