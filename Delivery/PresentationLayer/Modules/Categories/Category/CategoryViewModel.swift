//
//  CategoryViewModel.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation
import Combine


public final class CategoryViewModel: CategoryViewModelProtocol {
    public var searchedText: ObservableValue<String> = .init(value: "")
    public private(set) var products: ObservableValue<[Product]> = .init(value: [])
    public private(set) var error: ObservableValue<(any Error)?> = .init(value: nil)
    public private(set) var coordinator: (any CategoriesCoordinatorProtocol)?

    private var allProducts: ObservableValue<[Product]> = .init(value: [])
    private var cancellables = Set<AnyCancellable>()
    private let getProductsUseCase: any GetProductsUseCaseProtocol

    public init(coordinator: CategoriesCoordinatorProtocol?, getProductsUseCase: GetProductsUseCaseProtocol) {
        self.coordinator = coordinator
        self.getProductsUseCase = getProductsUseCase
    }

    public func fetchProducts() {
        Task {
            do {
                allProducts.value = try await getProductsUseCase.execute()
            } catch {
                self.error.value = error
            }
        }
    }
    
    public func selectProduct(id: String) {
        guard let product = products.value.first(where: { $0.id == id }) else { return }
        coordinator?.toProductScreen(product: product)
    }
}

private extension CategoryViewModel {
    func bind() {
        searchedText.$value.combineLatest(allProducts.$value).map { text, allProd in
            guard !text.isEmpty else { return allProd }
            return allProd.filter { product in
                product.name.lowercased().contains(text.lowercased())
            }
        }
        .assign(to: &products.$value)
    }
}
