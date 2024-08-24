//
//  AddProductToFavoriteUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 18.08.2024.
//


public class AddProductToFavoriteUseCase: AddProductToFavoriteUseCaseProtocol {
    private let categoryService: CategoryServiceProtocol

    public init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }

    public func execute(product: Product) async throws {
        try await categoryService.updateProduct(product)
    }
}
