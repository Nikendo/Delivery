//
//  MockCategoriesCoordinator.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import UIKit
import Delivery


final class MockCategoriesCoordinator: CategoriesCoordinatorProtocol {
    var navigationController: UINavigationController = UINavigationController()
    
    var toCategoryScreenCalled: Bool = false
    var toProductScreenCalled: Bool = false
    var selectedCategory: Delivery.Category?
    var selectedProduct: Delivery.Product?

    func start() {}
    func toCategoryScreen(category: Delivery.Category) {
        selectedCategory = category
        toCategoryScreenCalled = true
    }
}
