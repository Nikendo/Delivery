//
//  CategoryViewModelProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import DomainLayer
import DataLayer


@MainActor
public protocol CategoryViewModelProtocol: AnyObject {
    var tags: ObservableValue<[FilterItem]> { get }
    var products: ObservableValue<[Product]> { get }
    var searchedText: ObservableValue<String> { get set }
    var error: ObservableValue<Error?> { get }
    var coordinator: CategoriesCoordinatorProtocol? { get }

    func fetchProducts()
    func selectTag(id: String)
    func selectProduct(id: String)
    func addToFavorite(id: String)
    func addToCart(id: String)
}
