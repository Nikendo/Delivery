//
//  CategoryViewModelProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation


public protocol CategoryViewModelProtocol: AnyObject {
    var products: ObservableValue<[Product]> { get }
    var searchedText: ObservableValue<String> { get set }
    var error: ObservableValue<Error?> { get }
    var coordinator: CategoriesCoordinatorProtocol? { get }

    func fetchProducts()
    func selectProduct(id: String)
}