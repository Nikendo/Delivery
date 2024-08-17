//
//  CategoriesViewModelTests.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import XCTest
import Delivery
import Combine


final class CategoriesViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    private var userSessionManager: UserSessionManagerProtocol!
    private var getCategoriesUseCase: MockGetCategoriesUseCase!
    private var coordinator: MockCategoriesCoordinator!
    private var viewModel: CategoriesViewModel!

    override func setUp() {
        super.setUp()
        cancellables = []
        userSessionManager = MockUserSessionManager()
        getCategoriesUseCase = MockGetCategoriesUseCase()
        coordinator = MockCategoriesCoordinator()
        viewModel = CategoriesViewModel(coordinator: coordinator, getCategoriesUseCase: getCategoriesUseCase)
    }

    override func tearDown() {
        cancellables = nil
        userSessionManager = nil
        getCategoriesUseCase = nil
        coordinator = nil
        viewModel = nil
        super.tearDown()
    }

    func testGetCategoriesSuccess() {
        // Given
        let categories = [
            Category(id: UUID().uuidString, name: "Vegetables", count: 40),
            Category(id: UUID().uuidString, name: "Fruits", count: 32),
            Category(id: UUID().uuidString, name: "Bread", count: 22),
            Category(id: UUID().uuidString, name: "Sweet", count: 14)
        ]
        let expectation = XCTestExpectation(description: "Expectation - Categories fetched success")
        getCategoriesUseCase.categories = categories

        // Then
        viewModel.categories.$value
            .dropFirst()
            .sink { fetchedCategories in
                XCTAssertEqual(fetchedCategories, categories)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchCategories()

        wait(for: [expectation], timeout: 2.0)
    }

    func testGetCategoriesFailed() {
        // Given
        let categories = [
            Category(id: UUID().uuidString, name: "Vegetables", count: 40),
            Category(id: UUID().uuidString, name: "Fruits", count: 32),
            Category(id: UUID().uuidString, name: "Bread", count: 22),
            Category(id: UUID().uuidString, name: "Sweet", count: 14)
        ]
        let expectation = XCTestExpectation(description: "Expectation - Categories fetched failed")
        let testError = NSError(domain: "TestError", code: 1)
        getCategoriesUseCase.categories = categories
        getCategoriesUseCase.errorToThrow = testError

        // When
        viewModel.fetchCategories()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Then
            XCTAssertTrue(self.viewModel.categories.value.isEmpty, "Categories should be empty, but they are not empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testGetFilteredCategoriesSuccess() {
        // Given
        let categories = [
            Category(id: UUID().uuidString, name: "Vegetables", count: 40),
            Category(id: UUID().uuidString, name: "Vegetarian", count: 74),
            Category(id: UUID().uuidString, name: "Fruits", count: 32),
            Category(id: UUID().uuidString, name: "Bread", count: 22),
            Category(id: UUID().uuidString, name: "Sweet", count: 14)
        ]
        let expectedFilteredCategories = [
            categories[0],
            categories[1]
        ]
        let filterText = "vege"
        let expectation = XCTestExpectation(description: "Expectation - Get filtered categories success")

        getCategoriesUseCase.categories = categories

        // When
        viewModel.fetchCategories()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.searchedText.value = filterText

            // Then
            let actualFilteredCategories = self.viewModel.categories.value
            XCTAssertEqual(actualFilteredCategories, expectedFilteredCategories, "Actual filtered categories are not equal to expected")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testSelectCategorySuccess() {
        // Given
        let categories = [
            Category(id: UUID().uuidString, name: "Vegetables", count: 40),
            Category(id: UUID().uuidString, name: "Fruits", count: 32),
            Category(id: UUID().uuidString, name: "Bread", count: 22),
            Category(id: UUID().uuidString, name: "Sweet", count: 14)
        ]
        let expectedCategory = categories[1]

        let expectation = XCTestExpectation(description: "Expectation - Select category success")

        getCategoriesUseCase.categories = categories

        viewModel.fetchCategories()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // When
            self.viewModel.selectCategory(id: expectedCategory.id)

            // Then
            let actualCategory = self.coordinator.selectedCategory
            XCTAssertEqual(actualCategory, expectedCategory, "Actual selected category are not equal to expected")
            let actualResult = self.coordinator.toCategoryScreenCalled
            XCTAssertTrue(actualResult, "Coordinator's method 'toCategoryScreen' should be called when a category selected")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testSelectCategoryFailed() {
        // Given
        let categories = [
            Category(id: UUID().uuidString, name: "Vegetables", count: 40),
            Category(id: UUID().uuidString, name: "Fruits", count: 32),
            Category(id: UUID().uuidString, name: "Bread", count: 22),
            Category(id: UUID().uuidString, name: "Sweet", count: 14)
        ]
        
        let idsSet = Set(categories.map(\.id))
        var id = UUID().uuidString

        // Assign an id which doesn't contain in categories
        while idsSet.contains(id) {
            id = UUID().uuidString
        }

        let expectation = XCTestExpectation(description: "Expectation - Select category failed")

        getCategoriesUseCase.categories = categories

        viewModel.fetchCategories()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // When
            self.viewModel.selectCategory(id: id)

            // Then
            let actualCategory = self.coordinator.selectedCategory
            XCTAssertNil(actualCategory, "Coordinator's selected category should be nil")
            let actualResult = self.coordinator.toCategoryScreenCalled
            XCTAssertFalse(actualResult, "Coordinator's method 'toCategoryScreen' should not be called when a wrong category selected")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
