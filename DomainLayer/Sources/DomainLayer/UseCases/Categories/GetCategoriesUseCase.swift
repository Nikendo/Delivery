//
//  GetCategoriesUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 01.07.2024.
//


public final class GetCategoriesUseCase: GetCategoriesUseCaseProtocol {
    private let categoriesRepository: CategoriesRepository
    
    public init(categoriesRepository: CategoriesRepository) {
        self.categoriesRepository = categoriesRepository
    }

    public func execute() async throws -> [ProductCategory] {
        try await categoriesRepository.fetchCategories()
    }
}
