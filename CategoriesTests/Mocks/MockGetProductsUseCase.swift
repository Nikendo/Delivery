//
//  MockGetProductsUseCase.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Delivery


final class MockGetProductsUseCase: GetProductsUseCaseProtocol {
    var products: [Product] = []
    var errorToThrow: Error?

    func execute() async throws -> [Product] {
        try await Task.sleep(nanoseconds: 1_000_000)
        guard let errorToThrow else {
            return products
        }
        throw errorToThrow
    }
}
