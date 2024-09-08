//
//  CategoryRepository.swift
//  Delivery
//
//  Created by Shmatov Nikita on 10.08.2024.
//

import Foundation


public protocol CategoryRepository: AnyObject {
    func fetchProducts(for category: ProductCategory) async throws -> [Product]
    func updateProduct(_ product: Product) async throws
    func addProductToCart(_ product: Product) async throws
}
