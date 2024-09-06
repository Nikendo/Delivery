//
//  AddProductToCartUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//

import Foundation

public class AddProductToCartUseCase: AddProductToCartUseCaseProtocol {
    private let categoryService: CategoryServiceProtocol

    public init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }

    public func execute(product: Product) async throws {
        try await categoryService.addProductToCart(product)
    }
}
