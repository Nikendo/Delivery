//
//  ProductViewModel.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import Foundation
import Combine

public final class ProductViewModel: ProductViewModelProtocol {
    public private(set) var product: ObservableValue<Product>
    public private(set) var error: ObservableValue<(any Error)?> = .init(value: nil)
    public private(set) var coordinator: (any CategoriesCoordinatorProtocol)?

    private var cancellables: [AnyCancellable] = []
    private let addProductToFavoriteUseCase: any AddProductToFavoriteUseCaseProtocol
    private let addProductToCartUseCase: any AddProductToCartUseCaseProtocol

    public init(
        product: Product,
        coordinator: (any CategoriesCoordinatorProtocol)?,
        addProductToFavoriteUseCase: any AddProductToFavoriteUseCaseProtocol,
        addProductToCartUseCase: any AddProductToCartUseCaseProtocol
    ) {
        self.product = .init(value: product)        
        self.coordinator = coordinator
        self.addProductToFavoriteUseCase = addProductToFavoriteUseCase
        self.addProductToCartUseCase = addProductToCartUseCase
    }

    public func addToFavorite() {
        Task {
            do {
                let product = self.product.value
                try await self.addProductToFavoriteUseCase.execute(product: self.product.value)
                self.product.value = Product(
                    id: product.id,
                    imageUrls: product.imageUrls,
                    name: product.name,
                    description: product.description,
                    country: product.country,
                    price: product.price,
                    averageWeight: product.averageWeight,
                    weightUnit: product.weightUnit,
                    quantityType: product.quantityType,
                    kind: product.kind,
                    isFavorite: !product.isFavorite
                )
            } catch {
                self.error.value = error
            }
        }
    }

    public func addToCart() {
        Task {
            do {
                let product = self.product.value
                try await self.addProductToCartUseCase.execute(product: product)
            } catch {
                self.error.value = error
            }
        }
    }
}
