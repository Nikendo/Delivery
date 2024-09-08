//
//  AddProductToCartUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//

import Foundation

public class AddProductToCartUseCase: AddProductToCartUseCaseProtocol {
    private let categoryRepository: CategoryRepository

    public init(categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }

    public func execute(product: Product) async throws {
        try await categoryRepository.addProductToCart(product)
    }
}
