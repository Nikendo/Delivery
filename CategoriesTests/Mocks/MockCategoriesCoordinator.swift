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
    var selectedCategory: Delivery.Category?

    func start() {}
    func toCategoryScreen(category: Delivery.Category) {
        selectedCategory = category
        toCategoryScreenCalled = true
    }
}
