//
//  CategoriesCoordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit
import DomainLayer
import DataLayer


@MainActor
public final class CategoriesCoordinator: CategoriesCoordinatorProtocol {
    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let getCategoriesUseCase = GetCategoriesUseCase(categoriesRepository: FirebaseCategoriesRepository())
        let viewModel = CategoriesViewModel(coordinator: self, getCategoriesUseCase: getCategoriesUseCase)
        let viewController = CategoriesViewController(viewModel: viewModel)
        viewController.title = TabBarItems.categories.title
        navigationController.setViewControllers([viewController], animated: true)
    }

    public func toCategoryScreen(category: ProductCategory) {
        let service: CategoryRepository = FirebaseCategoryRepository()
        let getProductsUseCase = GetProductsUseCase(categoryRepository: service, category: category)
        let addProductToFavoriteUseCase = AddProductToFavoriteUseCase(categoryRepository: service)
        let viewModel = CategoryViewModel(
            coordinator: self,
            getProductsUseCase: getProductsUseCase,
            addProductToFavoriteUseCase: addProductToFavoriteUseCase
        )
        let viewController = CategoryViewController(viewModel: viewModel)
        viewController.title = category.name
        navigationController.pushViewController(viewController, animated: true)
    }

    public func toProductScreen(product: Product) {
        let service = FirebaseCategoryRepository()
        let addProductToFavoriteUseCase = AddProductToFavoriteUseCase(categoryRepository: service)
        let addProductToCartUseCase = AddProductToCartUseCase(categoryRepository: service)
        let viewModel = ProductViewModel(
            product: product,
            coordinator: self,
            addProductToFavoriteUseCase: addProductToFavoriteUseCase,
            addProductToCartUseCase: addProductToCartUseCase
        )
        let viewController = ProductViewController(viewModel: viewModel)
        viewController.title = product.name
        navigationController.pushViewController(viewController, animated: true)
    }
}
