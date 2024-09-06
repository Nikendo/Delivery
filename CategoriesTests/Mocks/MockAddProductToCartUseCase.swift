//
//  MockAddProductToCartUseCase.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 06.09.2024.
//

import Foundation
import Delivery

final class MockAddProductToCartUseCase: AddProductToCartUseCaseProtocol {
    var errorToThrow: Error?
    var productWasAddedToCart: Bool = false

    func execute(product: Product) async throws {
        try await Task.sleep(nanoseconds: 1_000_000)
        guard let errorToThrow else {
            productWasAddedToCart = true
            return
        }
        throw errorToThrow
    }
}
