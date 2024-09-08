//
//  CategoriesCoordinatorProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import UIKit
import DomainLayer


@MainActor
public protocol CategoriesCoordinatorProtocol: Coordinator {
    func toCategoryScreen(category: ProductCategory)
    func toProductScreen(product: Product)
}
