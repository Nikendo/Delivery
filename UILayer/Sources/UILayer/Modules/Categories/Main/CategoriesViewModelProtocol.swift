//
//  CategoriesViewModelProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import DomainLayer
import DataLayer


@MainActor
public protocol CategoriesViewModelProtocol: AnyObject {
    var categories: ObservableValue<[ProductCategory]> { get }
    var searchedText: ObservableValue<String> { get set }
    var error: ObservableValue<Error?> { get }
    var coordinator: CategoriesCoordinatorProtocol? { get }

    func fetchCategories()
    func selectCategory(id: String)
}
