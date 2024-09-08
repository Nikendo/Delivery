//
//  MockGetCategoriesUseCase.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import Delivery
import DomainLayer


final class MockGetCategoriesUseCase: GetCategoriesUseCaseProtocol {
    var categories: [ProductCategory] = []
    var errorToThrow: Error?

    func execute() async throws -> [ProductCategory] {
        try await Task.sleep(nanoseconds: 1_000_000)
        guard let errorToThrow else {
            return categories
        }
        throw errorToThrow
    }
}
