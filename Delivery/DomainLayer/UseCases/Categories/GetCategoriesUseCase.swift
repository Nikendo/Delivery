//
//  GetCategoriesUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import Foundation


public final class GetCategoriesUseCase: GetCategoriesUseCaseProtocol {
    private let categoriesService: CategoriesServiceProtocol
    
    init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
    }

    public func execute() async throws -> [Category] {
        try await categoriesService.fetchCategories()
    }
}
