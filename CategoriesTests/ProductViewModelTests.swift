//
//  ProductViewModelTests.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 24.08.2024.
//

import XCTest
import Delivery

final class ProductViewModelTests: XCTestCase {

    // MARK: - Properties

    // 1. add a product to favorites
    // 2. add a product to a cart

    private var product: Product!
    private var coordinator: MockCategoriesCoordinator!
    private var addProductToFavoriteUseCase: MockAddProductToFavoriteUseCase!
    private var addProductToCartUseCase: MockAddProductToCartUseCase!
    private var viewModel: ProductViewModel!

    // MARK: - Setup

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        product = MockProducts.vegetables.first!
        coordinator = MockCategoriesCoordinator()
        addProductToFavoriteUseCase = MockAddProductToFavoriteUseCase()
        addProductToCartUseCase = MockAddProductToCartUseCase()
        viewModel = ProductViewModel(
            product: product,
            coordinator: coordinator,
            addProductToFavoriteUseCase: addProductToFavoriteUseCase,
            addProductToCartUseCase: addProductToCartUseCase
        )
    }

    // MARK: - Tear Down

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        product = nil
        coordinator = nil
        addProductToFavoriteUseCase = nil
        addProductToCartUseCase = nil
        viewModel = nil
    }

    // MARK: - Add to favorites use cases

    func testAddProductToFavoriteSuccess() throws {
        // Given
        let expectation = XCTestExpectation(description: "Product is successfully added to favorite")
        let product = MockProducts.vegetables.first!

        // When
        viewModel.addToFavorite()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertNil(self.viewModel.error.value, "An error field should to be nil, but it contains an error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testAddProductToFavoriteFailed() throws {
        // Given
        let expectation = XCTestExpectation(description: "Product is not added to favorite")
        let product = MockProducts.vegetables.first!

        let testError = NSError(domain: "TestError", code: 1)

        // When
        addProductToFavoriteUseCase.errorToThrow = testError
        viewModel.addToFavorite()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertFalse(self.addProductToFavoriteUseCase.productWasAddedToFavorite, "An error field should contain error, but it contains nil")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    // MARK: - Add to cart use cases

    func testAddProductToCartSuccess() throws {
        // Given
        let expectation = XCTestExpectation(description: "Product is successfully added to a cart")
        let product = MockProducts.vegetables.first!

        // When
        viewModel.addToCart()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertNil(self.viewModel.error.value, "An error field should to be nil, but it contains an error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testAddProductToCartFailed() throws {
        // Given
        let expectation = XCTestExpectation(description: "Product is not added to a cart")
        let product = MockProducts.vegetables.first!

        let testError = NSError(domain: "TestError", code: 1)

        // When
        addProductToCartUseCase.errorToThrow = testError
        viewModel.addToCart()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertFalse(self.addProductToFavoriteUseCase.productWasAddedToFavorite, "An error field should contain error, but it contains nil")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
