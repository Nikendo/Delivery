//
//  AddProductToFavoriteUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 18.08.2024.
//


public class AddProductToFavoriteUseCase: AddProductToFavoriteUseCaseProtocol {
    private let categoryRepository: CategoryRepository

    public init(categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }

    public func execute(product: Product) async throws {
        try await categoryRepository.updateProduct(product)
    }
}
