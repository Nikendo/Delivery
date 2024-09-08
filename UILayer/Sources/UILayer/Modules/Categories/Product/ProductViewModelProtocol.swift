//
//  ProductViewModelProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import DomainLayer
import DataLayer


@MainActor
public protocol ProductViewModelProtocol: AnyObject {
    var product: ObservableValue<Product> { get }
    var error: ObservableValue<Error?> { get }
    var coordinator: CategoriesCoordinatorProtocol? { get }

    func addToFavorite()
    func addToCart()
}
