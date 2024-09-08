//
//  GetProductsUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 10.08.2024.
//

import Foundation


public final class GetProductsUseCase: GetProductsUseCaseProtocol {
    
    private let categoryRepository: CategoryRepository
    private let category: ProductCategory

    public init(categoryRepository: CategoryRepository, category: ProductCategory) {
        self.categoryRepository = categoryRepository
        self.category = category
    }

    public func execute() async throws -> [Product] {
        try await categoryRepository.fetchProducts(for: category)
    }
}
