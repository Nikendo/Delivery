//
//  CategoriesViewModel.swift
//  Delivery
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import Foundation
import Combine


public final class CategoriesViewModel: CategoriesViewModelProtocol {
    public private(set) var categories: ObservableValue<[Category]> = .init(value: [])
    public private(set) var error: ObservableValue<Error?> = .init(value: nil)
    public var searchedText: ObservableValue<String> = .init(value: "")

    public private(set) var coordinator: CategoriesCoordinatorProtocol?
    private var allCategories: ObservableValue<[Category]> = .init(value: [])
    private var cancellables = Set<AnyCancellable>()
    private let getCategoriesUseCase: GetCategoriesUseCaseProtocol

    public init(coordinator: CategoriesCoordinatorProtocol?, getCategoriesUseCase: GetCategoriesUseCaseProtocol) {
        self.coordinator = coordinator
        self.getCategoriesUseCase = getCategoriesUseCase
        bind()
    }

    public func fetchCategories() {
        Task {
            do {
                allCategories.value = try await getCategoriesUseCase.execute()
            } catch {
                self.error.value = error
            }
        }
    }

    public func selectCategory(id: String) {
        guard let category = allCategories.value.first(where: { $0.id == id }) else { return }
        coordinator?.toCategoryScreen(category: category)
    }
}

private extension CategoriesViewModel {
    func bind() {
        searchedText.$value.combineLatest(allCategories.$value).map { text, allCat in
            guard !text.isEmpty else { return allCat }
            return allCat.filter { category in
                category.name.lowercased().contains(text.lowercased())
            }
        }
        .assign(to: &categories.$value)
    }
}
