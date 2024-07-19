//
//  CategoryViewModelTests.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import XCTest
import Delivery
import Combine


final class CategoryViewModelTests: XCTestCase {

    // 1. presentation of products by category
    // 2. tags presentation
    // 3. products filtering by the Search field
    // 4. products filtering by the tags
    // 5. select a product
    // 6. add a product to favorites
    // 7. add a product to the cart

    private var cancellables: Set<AnyCancellable>!
    private var getProductsUseCase: MockGetProductsUseCase!
    private var coordinator: MockCategoriesCoordinator!
    private var viewModel: CategoryViewModel!


    override func setUp() {
        super.setUp()
        cancellables = []
        getProductsUseCase = MockGetProductsUseCase()
        coordinator = MockCategoriesCoordinator()
        viewModel = CategoryViewModel(coordinator: coordinator, getProductsUseCase: getProductsUseCase)
    }

    override func tearDown() {
        cancellables = nil
        getProductsUseCase = nil
        coordinator = nil
        viewModel = nil
        super.tearDown()
    }

    func testGetProductsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Products fetched")
        let products: [Product] = MockProducts.vegetables
        getProductsUseCase.products = products

        viewModel.products.$value
            .sink { fetchedProducts in
                // Then
                XCTAssertEqual(fetchedProducts, products, "Fetched products are not equal to expected.")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.fetchProducts()

        wait(for: [expectation], timeout: 2)
    }

    func testGetProductsFailed() {
        // Given
        let expectation = XCTestExpectation(description: "Products fetched")
        let testError = NSError(domain: "TestError", code: 1)
        let products: [Product] = MockProducts.vegetables
        getProductsUseCase.products = products
        getProductsUseCase.errorToThrow = testError

        viewModel.products.$value
            .sink { fetchedProducts in
                // Then
                XCTAssertTrue(fetchedProducts.isEmpty, "Fetched products are not equal to expected.")
                expectation.fulfill()
            }

        // When
        viewModel.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertTrue(self.viewModel.products.isEmpty, "Fetched products should be empty due to a simulated error, but they are not empty.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testGetFilteredProductsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Products fetched")
        let products: [Product] = MockProducts.vegetables
        getProductsUseCase.products = products
        let filterText: String = "Ca"
        let expectedFilteredProducts: [Product] = products.filter { $0.name.lowercased().contains(filterText.lowercased()) }

        // When
        viewModel.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            let actualProducts: [Product] = self.viewModel.products
            XCTAssertEqual(actualProducts, expectedFilteredProducts, "Actual filtered products are not equal to expected")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testSelectProductSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Products fetched")
        let products: [Product] = MockProducts.vegetables
        let expectedProduct = products[1]
        getProductsUseCase.products = products

        viewModel.fetchCategories()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // When
            self.viewModel.selectProduct(id: expectedProduct.id)

            // Then
            let actualProduct = self.coordinator.selectedProduct
            XCTAssertEqual(actualProduct, expectedProduct, "Actual selected product are not equal to expected")
            let actualResult = self.coordinator.toProductScreenCalled
            XCTAssertTrue(actualResult, "Coordinator's method 'toProductScreen' should be called when a product selected")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
