//
//  CategoriesTests.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import XCTest
import Delivery
import DomainLayer


final class CategoriesTests: XCTestCase {

    func testCategoryInitialization() {
        // Given
        let id = UUID().uuidString
        let name = "Vegetables"
        let count = 40

        // When
        let category = ProductCategory(id: id, name: name, count: count)

        // Then
        XCTAssertEqual(id, category.id, "Category's id property with value: \(category.id) is not equal to given id property with value: \(id)")
        XCTAssertEqual(name, category.name, "Category's name property with value: \(category.name) is not equal to given name property with value: \(name)")
        XCTAssertEqual(count, category.count, "Category's count property with value: \(category.count) is not equal to given count property with value: \(count)")
    }
}
