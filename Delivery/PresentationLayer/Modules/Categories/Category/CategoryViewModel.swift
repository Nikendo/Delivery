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
    public private(set) var tags: ObservableValue<[FilterItem]> = .init(value: [])
    public private(set) var products: ObservableValue<[Product]> = .init(value: [])
    public private(set) var error: ObservableValue<(any Error)?> = .init(value: nil)
    public private(set) var coordinator: (any CategoriesCoordinatorProtocol)?

    private var selectedTag: ObservableValue<FilterItem?> = .init(value: nil)
    private var allProducts: ObservableValue<[Product]> = .init(value: [])
    private var cancellables = Set<AnyCancellable>()
    private let getProductsUseCase: any GetProductsUseCaseProtocol

    public init(coordinator: CategoriesCoordinatorProtocol?, getProductsUseCase: GetProductsUseCaseProtocol) {
        self.coordinator = coordinator
        self.getProductsUseCase = getProductsUseCase
        bind()
    }

    public func fetchProducts() {
        Task {
            do {
                allProducts.value = try await getProductsUseCase.execute()
                tags.value = allProducts.value.map { FilterItem(id: UUID().uuidString, text: $0.name, selected: false) }
            } catch {
                self.error.value = error
            }
        }
    }

    public func selectTag(id: String) {
        guard let tag = tags.value.first(where: { $0.id == id }) else { return }

        guard let selectedTag = selectedTag.value else {
            selectedTag.value = FilterItem(id: tag.id, text: tag.text, selected: true)
            return
        }

        self.selectedTag.value = tag.id == selectedTag.id ? nil : FilterItem(id: tag.id, text: tag.text, selected: true)
        tags.value = getUpdatedTags(selectedTag: self.selectedTag.value)
    }

    public func selectProduct(id: String) {
        guard let product = products.value.first(where: { $0.id == id }) else { return }
        coordinator?.toProductScreen(product: product)
    }
}

private extension CategoryViewModel {
    func getUpdatedTags(selectedTag: FilterItem?) -> [FilterItem] {
        let unselectedTags = tags.value.map { FilterItem(id: $0.id, text: $0.text, selected: false) }
        guard let selectedTag else { return unselectedTags }
        return unselectedTags.map {
            if selectedTag.id == $0.id {
                return FilterItem(id: $0.id, text: $0.text, selected: selectedTag.selected)
            }

            return FilterItem(id: $0.id, text: $0.text, selected: false)
        }
    }

    func bind() {
        selectedTag.$value.map { [weak tags] tag in
            guard let tag, let tags else {
                return tags?.value.map { FilterItem(id: $0.id, text: $0.text, selected: false) } ?? []
            }

            let unselectedTags = tags.value.map { FilterItem(id: $0.id, text: $0.text, selected: false) }
            return unselectedTags.map {
                if tag.id == $0.id {
                    return FilterItem(id: $0.id, text: $0.text, selected: tag.selected)
                }

                return FilterItem(id: $0.id, text: $0.text, selected: $0.selected)
            }
        }
        .assign(to: &tags.$value)

        searchedText.$value.combineLatest(allProducts.$value, selectedTag.$value).map { text, allProd, tag in
            if let tag = tag {
                return allProd.filter { product in product.name.lowercased() == tag.text.lowercased() }
            }

            guard !text.isEmpty else { return allProd }
            return allProd.filter { product in
                product.name.lowercased().contains(text.lowercased())
            }
        }
        .assign(to: &products.$value)
    }
}
