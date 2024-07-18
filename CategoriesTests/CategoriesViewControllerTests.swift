//
//  CategoriesViewControllerTests.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import XCTest
import Delivery


final class CategoriesViewControllerTests: XCTestCase {
    var viewController: CategoriesViewController!

    override func setUp() {
        super.setUp()
        
        viewController = CategoriesViewController(viewModel: MockCategoriesViewModel())
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testViewControllerIsNotNil() {
        XCTAssertNotNil(viewController)
    }
}
