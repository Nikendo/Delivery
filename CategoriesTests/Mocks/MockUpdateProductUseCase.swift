//
//  MockAddProductToFavoriteUseCase.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import Delivery


final class MockAddProductToFavoriteUseCase: UpdateProductUseCaseProtocol {
    var errorToThrow: Error?
    var productWasAddedToFavorite: Bool = false

    func execute(product: Product) async throws {
        try await Task.sleep(nanoseconds: 1_000_000)
        guard let errorToThrow else {
            productWasAddedToFavorite = true
            return
        }
        throw errorToThrow
    }
}
