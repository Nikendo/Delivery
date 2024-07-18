//
//  MockCategoriesViewModel.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import Delivery


final class MockCategoriesViewModel: CategoriesViewModelProtocol {
    var categories: ObservableValue<[Delivery.Category]> = .init(value: [])
    var searchedText: ObservableValue<String> = .init(value: "")
    var error: ObservableValue<Error?> = .init(value: nil)
    var coordinator: CategoriesCoordinatorProtocol?
    
    init() {}

    func fetchCategories() {}
    func selectCategory(id: String) {}
}
