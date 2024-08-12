//
//  GetProductsUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 10.08.2024.
//

import Foundation


public final class GetProductsUseCase: GetProductsUseCaseProtocol {
    
    private let categoryService: CategoryServiceProtocol
    private let category: Category

    public init(categoryService: CategoryServiceProtocol, category: Category) {
        self.categoryService = categoryService
        self.category = category
    }

    public func execute() async throws -> [Product] {
        try await categoryService.fetchProducts(for: category)
    }
}
