//
//  CategoriesCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public final class CategoriesCoordinator: CategoriesCoordinatorProtocol {
    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let getCategoriesUseCase = GetCategoriesUseCase(categoriesService: FirebaseCategoriesService())
        let viewModel = CategoriesViewModel(coordinator: self, getCategoriesUseCase: getCategoriesUseCase)
        let viewController = CategoriesViewController(viewModel: viewModel)
        viewController.title = TabBarItems.categories.title
        navigationController.setViewControllers([viewController], animated: true)
    }

    public func toCategoryScreen(category: Category) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = category.name
        navigationController.pushViewController(viewController, animated: true)
    }

    public func toProductScreen(product: Product) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = product.name
        navigationController.pushViewController(viewController, animated: true)
    }
}
