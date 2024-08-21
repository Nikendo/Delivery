//
//  CategoryServiceProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 10.08.2024.
//

import Foundation


public protocol CategoryServiceProtocol: AnyObject {
    func fetchProducts(for category: Category) async throws -> [Product]
    func updateProduct(_ product: Product) async throws
}
